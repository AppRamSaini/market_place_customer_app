import 'package:market_place_customer/screens/vendors_details_and_offers/already_purchesed_dialog.dart';

import '../../bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import '../../bloc/customer_registration/fetch_profile_bloc/fetch_profile_state.dart';
import '../../utils/exports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  CustomerRegistrationModel? customerRegistrationModel;
  late List settingTitles;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isLoggedIn = await checkedLogin(context);
      if (!isLoggedIn) return;
    });
  }

  Future _reFetchData() async => context
      .read<FetchProfileDetailsBloc>()
      .add(FetchProfileEvent(context: context));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await exitPageDialog(context);
        return shouldExit;
      },
      child:
          // MultiBlocListener(
          //   listeners: [
          //     // BlocListener<CustomerProfileUpdateBloc, CustomerProfileUpdateState>(
          //     //   listener: (context, state) async {
          //     //     EasyLoading.dismiss();
          //     //     if (state is CustomerProfileUpdateSuccess) {
          //     //       _reFetchData();
          //     //     }
          //     //   },
          //     // )
          //   ],
          //   child:

          Scaffold(
        body: BlocBuilder<FetchProfileDetailsBloc, FetchProfileDetailsState>(
          builder: (context, state) {
            if (state is FetchProfileDetailsLoading) {
              return SingleChildScrollView(child: profileSimmerLoading());
            } else if (state is FetchProfileDetailsFailure) {
              return Center(
                  child: Text(state.error.toString(),
                      style: AppStyle.medium_14(AppColors.redColor)));
            } else if (state is FetchProfileDetailsSuccess) {
              final profile = state.profileModel.data;
              /*      if (businessProfile != null) {
                    merchantRegistrationModel = MerchantRegistrationModel(
                        name: businessProfile.vendor?.name ?? '',
                        mobile: businessProfile.vendor?.phone?.toString() ?? '',
                        email: businessProfile.vendor?.email?.toString() ?? '',
                        country: businessProfile.businessDetails?.country ?? '',
                        businessName:
                            businessProfile.businessDetails?.businessName ?? '',
                        businessRegistrationNo:
                            businessProfile.businessDetails?.businessRegister ??
                                '',
                        gstNumber:
                            businessProfile.businessDetails?.gstNumber ?? '',
                        state: businessProfile.businessDetails?.state ?? '',
                        city: businessProfile.businessDetails?.city ?? '',
                        pinCode:
                            businessProfile.businessDetails?.pincode?.toString() ??
                                '',
                        landMark: businessProfile.businessDetails?.area ?? '',
                        category: businessProfile.businessDetails?.category?.id
                                .toString() ??
                            '',
                        subCategory: businessProfile
                                .businessDetails?.subcategory?.id
                                .toString() ??
                            '',
                        lat: businessProfile.businessDetails?.lat?.toString() ??
                            '',
                        long: businessProfile.businessDetails?.long?.toString() ??
                            '',
                        address: businessProfile.businessDetails?.address ?? '',
                        aadhaarFront:
                            businessProfile.document?.aadhaarFront ?? '',
                        aadhaarBack: businessProfile.document?.aadhaarBack ?? '',
                        panImage: businessProfile.document?.panCardImage ?? '',
                        gstCertificate:
                            businessProfile.document?.gstCertificate ?? '',
                        businessLogo:
                            businessProfile.document?.businessLogo ?? '',
                        weekOffDay:
                            businessProfile.timing?.weeklyOffDay?.toIso8601String() ??
                                '',
                        openingHours: mapOpeningHours(businessProfile.timing?.openingHours),
                        businessImages: businessProfile.businessDetails!.businessImage ?? []);
                  }*/

              settingTitles = [
                {
                  "title": "Update Profile",
                  "icon": Icons.person,
                  "page": const EditProfilePage()
                },
                {"title": "FAQ", "icon": Icons.help_outline_outlined},
                {"title": "Help & Support", "icon": Icons.info_outline_rounded},
                {"title": "Privacy Policy", "icon": Icons.privacy_tip_outlined},
                {
                  "title": "Delete Account",
                  "icon": Icons.delete_forever_sharp,
                  "page": const DeleteUserAccount()
                },
                {"title": "Logout", "icon": Icons.logout},
              ];
              return RefreshIndicator(
                onRefresh: _reFetchData,
                child: CustomScrollView(
                  slivers: [
                    customSliverAppbar(
                      expandedHeight: size.height * 0.2,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Profile Settings",
                              style: AppStyle.medium_18(AppColors.themeColor)),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 5),
                                child: GestureDetector(
                                  // onTap: () => AppRouter().navigateTo(
                                  //     context, const NotificationScreen()),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.theme10,
                                    child: const Icon(
                                      Icons.notifications,
                                      color: AppColors.themeColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              // BlocBuilder<NotificationsBloc, NotificationsState>(
                              //     builder: (context, state) {
                              //       if (state is NotificationsSuccess) {
                              //         final user = state.getNotificationModel.data;
                              //         return user!.unread ==0
                              //             ? SizedBox()
                              //             :

                              CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.redColor,
                                child: Text(
                                  '12+',
                                  style:
                                      AppStyle.normal_10(AppColors.whiteColor),
                                ),
                              )

                              // ;
                              //   } else {
                              //     return SizedBox();
                              //   }
                              // })
                            ],
                          )
                        ],
                      ),
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          var percent =
                              ((constraints.maxHeight - kToolbarHeight) /
                                      (size.height * 0.2 - kToolbarHeight))
                                  .clamp(0.0, 1.0);

                          return FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Container(color: AppColors.theme5),
                            titlePadding: EdgeInsets.zero,
                            title: percent > 0.5
                                ? Opacity(
                                    opacity: percent,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.01,
                                          vertical: size.height * 0.014),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.theme5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: profilePickImage(
                                                      profile!.avatar! ?? ''))),
                                          const SizedBox(width: 2),
                                          // Text section
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      profile.name ?? '',
                                                      style:
                                                          AppStyle.semiBold_14(
                                                              AppColors
                                                                  .blackColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "+91 ${profile!.phone.toString()}",
                                                    style: AppStyle.normal_10(
                                                        AppColors.black20),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          );
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Align(
                          alignment: Alignment.center,
                          child: settingsWidget(
                              onTap: () {
                                if (index != 5) {
                                  AppRouter().navigateTo(
                                      context, settingTitles[index]['page']);
                                } else {
                                  logOutPermissionDialog(context);
                                }
                              },
                              title: settingTitles[index]['title'],
                              icon: settingTitles[index]['icon']),
                        ),
                        childCount: settingTitles.length,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      // ),
      // ),
    );
  }
}
