import 'package:market_place_customer/screens/auth/otp_verify.dart';
import 'package:market_place_customer/utils/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  String? validText;

  returnValidation(String value) {
    if (value == null || value.isEmpty) {
      validText = 'Please enter number';
    } else if (value.length < 9) {
      validText = 'Please enter minimum 10 characters of mobile number';
    } else if (value.length > 9) {
      validText = '';
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.034),
        child: SingleChildScrollView(
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
                  child: Image.asset(Assets.loginImg)),
              SizedBox(height: size.height * 0.06),
              Text("Welcome to Market Place",
                  style: AppStyle.bold_28(AppColors.themeColor)),
              const SizedBox(height: 5),
              Text(
                  "Log in with your mobile to explore and buy coupons for restaurants, salons, clothes, and more.",
                  style: AppStyle.normal_16(AppColors.blackColor)),
              SizedBox(height: size.height * 0.03),
              Text("Mobile Number",
                  style: AppStyle.normal_14(AppColors.black20)),
              SizedBox(height: size.height * 0.01),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'Enter your mobile number',
                  controller: mobileController,
                  validator: null,
                  onChanged: returnValidation),
              SizedBox(height: size.height * 0.005),
              Text(validText ?? '',
                  style: AppStyle.normal_13(AppColors.redColor)),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: globalBottomPadding(context),
                child: CustomButton(
                  minWidth: size.width,
                  onPressed: () {
                    validText ??= 'Please enter number';
                    setState(() {});
                    if (validText!.isEmpty) {
                      context.read<AuthBloc>().add(SendOtpRequested(
                          mobileController.text.toString(), context));
                    }
                  },
                  txt: "Send OTP",
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is AuthLoading) {
            EasyLoading.show();
          } else if (state is AuthSuccess) {
            final message = state.user.message.toString();
            final status = state.user.status;
            if (status == true) {
              if (state.type == AuthFlowType.login) {
                snackBar(context, message, AppColors.green);
                AppRouter().navigateTo(
                    context,
                    OtpVerify(
                        mobileNumber: mobileController.text.toString(),
                        location: ''));
              }
            } else {
              snackBar(context, message, AppColors.redColor);
            }
          } else if (state is AuthFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
          }
        },
        child: const SizedBox(),
      ),
    );
  }
}
