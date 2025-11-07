import 'package:market_place_customer/utils/exports.dart';

class CustomerRegistrationPage extends StatefulWidget {
  final String mobile;

  const CustomerRegistrationPage({super.key, required this.mobile});

  @override
  State<CustomerRegistrationPage> createState() =>
      CustomerRegistrationPageState();
}

class CustomerRegistrationPageState extends State<CustomerRegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mobileController.text = widget.mobile.toString();
  }

  XFile? businessLogo;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerSignupBloc, CustomerSignupState>(
      listener: (context, state) async {
        EasyLoading.dismiss();
        if (state is CustomerSignupLoading) {
          EasyLoading.show();
        } else if (state is CustomerSignupSuccess) {
          final signupData = state.customerSignupModel.data;
          final message =
              state.customerSignupModel.message ?? "Signup successful!";
          snackBar(context, message, AppColors.green);

          if (signupData != null) {
            final role = signupData.role ?? '';
            await LocalStorage.setString(Pref.roleType, role);

            final token = signupData.token;
            if (token != null && token.isNotEmpty) {
              await LocalStorage.setString(Pref.token, token);
            }

            final user = signupData.user;
            if (user != null) {
              await LocalStorage.setString(
                  Pref.userId, user.id?.toString() ?? '');
              await LocalStorage.setString(Pref.userName, user.name ?? '');
            }

            /// fetch the api data
            fetchApiData(context);

            AppRouter()
                .navigateAndClearStack(context, const CustomerDashboard());
          } else {
            snackBar(context, "Invalid response from server. Please try again.",
                AppColors.redColor);
          }
        } else if (state is CustomerSignupFailure) {
          snackBar(context, state.error.toString(), AppColors.redColor);
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        appBar: customAppbar(context: context, title: "Registration"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: backOrNextBtn(
            text2: "Submit",
            context: context,
            onBack: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            onNext: () {
              FocusScope.of(context).unfocus();
              CustomerRegistrationModel model = CustomerRegistrationModel(
                  name: nameController.text.toString(),
                  mobile: mobileController.text.toString(),
                  email: emailController.text.toString());

              if (_formKey.currentState!.validate()) {
                context
                    .read<CustomerSignupBloc>()
                    .add(CustomerSignupEvent(model, context));
              }
            }),
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Name",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      keyboardType: TextInputType.text,
                      hintText: 'Your name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Mobile Number",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      keyboardType: TextInputType.phone,
                      readOnly: true,
                      hintText: 'Mobile number',
                      suffix: const Icon(Icons.verified_sharp,
                          color: AppColors.green),
                      controller: mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Email Address (Optional)",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your email',
                    controller: emailController,
                    validator: validateEmail,
                  ),
                  SizedBox(height: size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
