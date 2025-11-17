import 'package:market_place_customer/utils/exports.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String imgUrl = '';

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final profileState = context.read<FetchProfileDetailsBloc>().state;
    if (profileState is FetchProfileDetailsSuccess) {
      final profile = profileState.profileModel.customerProfileData;
      nameController.text = profile!.name ?? "";
      emailController.text = profile.email ?? "";
      mobileController.text = profile.phone.toString() ?? "";
      addressController.text = LocalStorage.getString(Pref.location) ?? "";
      imgUrl = profile.avatar!.toString();
    }
  }

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Update Profile"),
      body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is UpdateProfileLoading) {
            EasyLoading.show();
          } else if (state is UpdateProfileSuccess) {
            snackBar(context, "Profile updated successfully");
            Navigator.pop(context);
          } else if (state is UpdateProfileFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.themeColor.withOpacity(0.2),
                              AppColors.themeColor.withOpacity(0.05),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.themeColor.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: _pickedImage != null
                                ? Image.file(_pickedImage!,
                                    width: 110, height: 110, fit: BoxFit.cover)
                                : Image.network(
                                    imgUrl,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      Assets.dummy,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      // Camera Button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            _pickedImage = await pickImageSheet(context);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppColors.themeColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 8)
                                ]),
                            child: const Icon(Icons.camera_alt_rounded,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                buildLabel("Name"),
                CustomTextField(
                    controller: nameController,
                    hintText: "Enter your Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    }),
                buildLabel("Mobile Number"),
                CustomTextField(
                    controller: mobileController,
                    readOnly: true,
                    suffix: const Icon(Icons.verified, color: AppColors.green)),
                SizedBox(height: size.height * 0.02),
                buildLabel("Email Address"),
                CustomTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    validator: validateEmail),
                buildLabel("Address"),
                CustomTextField(
                    readOnly: true,
                    controller: addressController,
                    hintText: "Enter your address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    }),
                const SizedBox(height: 25),
                CustomButtons.primary(
                  width: size.width,
                  text: "Submit",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      File? imageUrl = _pickedImage != null
                          ? File(_pickedImage!.path)
                          : File('null');

                      context.read<UpdateProfileBloc>().add(
                          UpdateProfileSubmitted(
                              context: context,
                              name: nameController.text.toString(),
                              email: emailController.text.toString(),
                              phone: mobileController.text.toString(),
                              imageFile: imageUrl));
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 6),
    child: Text(
      text,
      style: AppStyle.semiBold_14(AppColors.blackColor.withOpacity(0.8)),
    ),
  );
}
