import 'package:animate_do/animate_do.dart'; // for animations
import 'package:market_place_customer/screens/dilogs/delete_account.dart';
import 'package:market_place_customer/utils/exports.dart';

class DeleteUserAccount extends StatefulWidget {
  const DeleteUserAccount({super.key});

  @override
  State<DeleteUserAccount> createState() => _DeleteUserAccountState();
}

class _DeleteUserAccountState extends State<DeleteUserAccount>
    with SingleTickerProviderStateMixin {
  String? selectedValue;

  List<String> reasonList = [
    'Find a Better Alternative',
    'Need a Break',
    'Do not find it useful anymore',
    'Too many notifications',
    'Privacy concerns',
    'App is slow or buggy',
    'Switching to another device/platform',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(title: 'Delete Account', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 20),

              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    Assets.dummy,
                    width: size.width * 0.70,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                  decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.red.shade200)),
                  child: Column(
                    children: [
                      Icon(Icons.warning_rounded,
                          color: Colors.red.shade400, size: 40),
                      const SizedBox(height: 10),
                      Text("Delete Your Account",
                          style: AppStyle.medium_20(Colors.red.shade400)),
                      const SizedBox(height: 6),
                      Text(
                        "We’re sorry to see you go! Share your reason before deleting your account permanently.",
                        textAlign: TextAlign.center,
                        style: AppStyle.medium_14(AppColors.blackColor),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 Reason Heading
              FadeInUp(
                duration: const Duration(milliseconds: 650),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Reason",
                    style: AppStyle.medium_18(
                        AppColors.themeColor.withOpacity(.9)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// 🔥 Dropdown Animation
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Reason Type',
                      style: AppStyle.normal_16(AppColors.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: reasonList
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: AppStyle.medium_16(
                                    AppColors.blackColor.withOpacity(.9)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() => selectedValue = value);
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.blackColor.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 25,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.blackColor.withOpacity(.2)),
                      ),
                      maxHeight: size.height * 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              /// 🔥 Delete Button Animation
              FadeInUp(
                duration: const Duration(milliseconds: 750),
                child: GestureDetector(
                  onTap: () {
                    if (selectedValue != null) {
                      showDeleteAccountDialog(context, onConfirm: () {
                        EasyLoading.show();
                        Future.delayed(const Duration(seconds: 2), () {
                          EasyLoading.dismiss();
                          LocalStorage.clearAll(context);
                        });
                      });
                    } else {
                      snackBar(context, 'Please select a reason',
                          AppColors.redColor);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Delete Account',
                        style: AppStyle.medium_16(AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
