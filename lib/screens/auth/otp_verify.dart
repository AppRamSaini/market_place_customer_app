import 'package:market_place_customer/screens/auth/registration.dart';
import 'package:market_place_customer/utils/exports.dart';

class OtpVerify extends StatefulWidget {
  final String mobileNumber;
  final String location;
  const OtpVerify(
      {super.key, required this.mobileNumber, required this.location});

  @override
  State<OtpVerify> createState() => OtpVerifyState();
}

class OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _otpController = TextEditingController();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  Timer? timer;
  int startOtpTimer = 30;

  void startCountdownTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    startOtpTimer = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (callback) {
      if (startOtpTimer == 0) {
        callback.cancel();
        setState(() {});
      } else {
        startOtpTimer--;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    startCountdownTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  String? validOtpText;
  returnValidation(String value) {
    if (value == null || value.isEmpty) {
      validOtpText = 'Please enter OTP';
    } else if (value.length < 6) {
      validOtpText =
          'Please enter the 6-digit OTP received on your mobile number';
    } else if (value.length > 5) {
      validOtpText = '';
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: AppStyle.medium_20(AppColors.themeColor),
      decoration: BoxDecoration(
          color: AppColors.theme10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white10)));

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VerifyOtpBloc, VerifyOtpState>(
          listener: (context, state) async {
            EasyLoading.dismiss();
            if (state is OtpVerifyLoading) {
              EasyLoading.show();
            } else if (state is OtpVerifySuccess) {
              final message = state.userOtpModel.message.toString();
              snackBar(context, message, AppColors.green);
              final role = state.userOtpModel.data!.role.toString();
              if (state.userOtpModel.data!.token != null) {
                final token = state.userOtpModel.data!.token.toString();
                await LocalStorage.setString(Pref.token, token);
              }
              await LocalStorage.setString(Pref.roleType, role);
              if (state.userOtpModel.data!.user != null && role == 'customer') {
                AppRouter()
                    .navigateAndClearStack(context, const CustomerDashboard());
              } else {
                AppRouter().navigateTo(
                    context,
                    CustomerRegistrationPage(
                        mobile: widget.mobileNumber.toString()));
              }
            } else if (state is OtpVerifyFailure) {
              snackBar(context, state.error.toString(), Colors.red);
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            EasyLoading.dismiss();
            if (state is AuthLoading) {
              EasyLoading.show();
            } else if (state is AuthSuccess) {
              if (state.user.status == true) {
                if (state.type == AuthFlowType.resendOtp) {
                  startCountdownTimer();
                  _otpController.clear();
                  snackBar(context, "Opt Resent Successfully", AppColors.green);
                }
              } else {
                snackBar(
                    context, state.user.message.toString(), AppColors.redColor);
              }
            } else if (state is AuthFailure) {
              snackBar(context, state.error.toString(), AppColors.redColor);
            }
          },
        )
      ],
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SingleChildScrollView(
          padding: EdgeInsets.all(size.width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                      backgroundColor: AppColors.white10,
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 20, color: AppColors.themeColor))),
              SizedBox(height: size.height * 0.08),
              Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Image.asset(Assets.verifyOtpImg)),
              SizedBox(height: size.height * 0.1),
              Text("Enter OTP", style: AppStyle.bold_28(AppColors.themeColor)),
              const SizedBox(height: 5),
              Text(
                  "We’ve sent a 6-digit code to your mobile. Enter it below to continue.",
                  style: AppStyle.normal_14(AppColors.blackColor)),
              SizedBox(height: size.height * 0.03),
              Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (_) => const SizedBox(width: 5),
                onChanged: returnValidation,
              ),
              const SizedBox(height: 2),
              Text(validOtpText ?? '',
                  style: AppStyle.normal_13(AppColors.redColor)),
              SizedBox(height: size.height * 0.025),
              CustomButton(
                minWidth: size.width,
                onPressed: () async {
                  validOtpText ??= 'Please enter OTP';
                  setState(() {});

                  if (validOtpText!.isEmpty) {
                    context.read<VerifyOtpBloc>().add(SubmitOtpEvent(
                        mobileNumber: widget.mobileNumber.toString(),
                        role: "customer",
                        otp: _otpController.text.toString(),
                        context: context));
                  }
                },
                txt: "Verify OTP",
              ),
              SizedBox(height: size.height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      startOtpTimer > 0
                          ? TextSpan(
                              text: "Resend In $startOtpTimer sec",
                              style: AppStyle.medium_16(AppColors.themeColor))
                          : TextSpan(
                              text: "Resend OTP?",
                              style: AppStyle.medium_16(AppColors.themeColor)
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                              recognizer: _tapGestureRecognizer
                                ..onTap = () {
                                  context.read<AuthBloc>().add(
                                      ResendOtpRequested(
                                          widget.mobileNumber.toString(),
                                          context));
                                },
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
