import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_state.dart';
import 'package:market_place_customer/bloc/update_profile/update_profile_bloc.dart';
import 'package:market_place_customer/bloc/update_profile/update_profile_state.dart';
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
      final profile = profileState.profileModel.data;
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
            // context
            //     .read<DriverProfileBloc>()
            //     .add(FetchDriverProfileEvent(context: context));
            Navigator.pop(context);
          } else if (state is UpdateProfileFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          color: AppColors.themeColor,
                          dashPattern: const [12, 12, 12, 12],
                          padding: const EdgeInsets.all(5),
                          radius: const Radius.circular(100),
                          child: Container(
                            width: size.height * 0.13,
                            height: size.height * 0.13,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Container(
                              height: size.height * 0.13,
                              decoration: const BoxDecoration(
                                  color: AppColors.themeColor,
                                  shape: BoxShape.circle),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: _pickedImage != null
                                      ? Image.file(File(_pickedImage!.path),
                                          width: size.height * 0.13,
                                          height: size.height * 0.13,
                                          fit: BoxFit.cover)
                                      : profilePickImage(imgUrl)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.09,
                        right: size.width * 0.31,
                        child: GestureDetector(
                          onTap: () async {
                            _pickedImage = await pickImageSheet(context);
                            setState(() {});
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColors.themeColor,
                            child: Icon(Icons.camera_alt_rounded,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text("Name", style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      controller: nameController,
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.025),
                  Text("Mobile Number",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                    readOnly: true,
                    controller: mobileController,
                    suffix: Icon(Icons.verified_sharp,color: AppColors.green),
                    hintText: 'Enter your mobile number',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your mobile number";
                      }
                      return null;
                    },
                  ),     SizedBox(height: size.height * 0.025),
                  Text("Email Address",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                    controller: emailController,
                    hintText: 'Enter your email address',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your email address";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: size.height * 0.025),
                  Text("Address",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                    controller: addressController,
                    hintText: 'Enter your address',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.035),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // context.read<UpdateProfileBloc>().add(
                        //     UpdateProfileSubmitted(
                        //         context: context,
                        //         email: emailController.text.toString(),
                        //         name: nameController.text.toString(),
                        //         address: addressController.text.toString(),
                        //         licenseNo: drivingLicController.text.toString(),
                        //         imageFile: _pickedImage ?? null));
                      }
                    },
                    txt: "Submit",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
