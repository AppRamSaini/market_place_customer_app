// import 'package:market_place_customer/screens/vendors_details_and_offers/already_purchesed_dialog.dart';
//
// import '../../bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
// import '../../bloc/customer_registration/fetch_profile_bloc/fetch_profile_state.dart';
// import '../../utils/exports.dart';
//
// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});
//
//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   CustomerRegistrationModel? customerRegistrationModel;
//   late List settingTitles;
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       bool isLoggedIn = await checkedLogin(context);
//       if (!isLoggedIn) return;
//     });
//   }
//
//   Future _reFetchData() async => context
//       .read<FetchProfileDetailsBloc>()
//       .add(FetchProfileEvent(context: context));
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool shouldExit = await exitPageDialog(context);
//         return shouldExit;
//       },
//       child:
//           // MultiBlocListener(
//           //   listeners: [
//           //     // BlocListener<CustomerProfileUpdateBloc, CustomerProfileUpdateState>(
//           //     //   listener: (context, state) async {
//           //     //     EasyLoading.dismiss();
//           //     //     if (state is CustomerProfileUpdateSuccess) {
//           //     //       _reFetchData();
//           //     //     }
//           //     //   },
//           //     // )
//           //   ],
//           //   child:
//
//           Scaffold(
//         body: BlocBuilder<FetchProfileDetailsBloc, FetchProfileDetailsState>(
//           builder: (context, state) {
//             if (state is FetchProfileDetailsLoading) {
//               return SingleChildScrollView(child: profileSimmerLoading());
//             } else if (state is FetchProfileDetailsFailure) {
//               return Center(
//                   child: Text(state.error.toString(),
//                       style: AppStyle.medium_14(AppColors.redColor)));
//             } else if (state is FetchProfileDetailsSuccess) {
//               final profile = state.profileModel.data;
//               /*      if (businessProfile != null) {
//                     merchantRegistrationModel = MerchantRegistrationModel(
//                         name: businessProfile.vendor?.name ?? '',
//                         mobile: businessProfile.vendor?.phone?.toString() ?? '',
//                         email: businessProfile.vendor?.email?.toString() ?? '',
//                         country: businessProfile.businessDetails?.country ?? '',
//                         businessName:
//                             businessProfile.businessDetails?.businessName ?? '',
//                         businessRegistrationNo:
//                             businessProfile.businessDetails?.businessRegister ??
//                                 '',
//                         gstNumber:
//                             businessProfile.businessDetails?.gstNumber ?? '',
//                         state: businessProfile.businessDetails?.state ?? '',
//                         city: businessProfile.businessDetails?.city ?? '',
//                         pinCode:
//                             businessProfile.businessDetails?.pincode?.toString() ??
//                                 '',
//                         landMark: businessProfile.businessDetails?.area ?? '',
//                         category: businessProfile.businessDetails?.category?.id
//                                 .toString() ??
//                             '',
//                         subCategory: businessProfile
//                                 .businessDetails?.subcategory?.id
//                                 .toString() ??
//                             '',
//                         lat: businessProfile.businessDetails?.lat?.toString() ??
//                             '',
//                         long: businessProfile.businessDetails?.long?.toString() ??
//                             '',
//                         address: businessProfile.businessDetails?.address ?? '',
//                         aadhaarFront:
//                             businessProfile.document?.aadhaarFront ?? '',
//                         aadhaarBack: businessProfile.document?.aadhaarBack ?? '',
//                         panImage: businessProfile.document?.panCardImage ?? '',
//                         gstCertificate:
//                             businessProfile.document?.gstCertificate ?? '',
//                         businessLogo:
//                             businessProfile.document?.businessLogo ?? '',
//                         weekOffDay:
//                             businessProfile.timing?.weeklyOffDay?.toIso8601String() ??
//                                 '',
//                         openingHours: mapOpeningHours(businessProfile.timing?.openingHours),
//                         businessImages: businessProfile.businessDetails!.businessImage ?? []);
//                   }*/
//
//               settingTitles = [
//                 {
//                   "title": "Update Profile",
//                   "icon": Icons.person,
//                   "page": const EditProfilePage()
//                 },
//                 {"title": "FAQ", "icon": Icons.help_outline_outlined},
//                 {"title": "Help & Support", "icon": Icons.info_outline_rounded},
//                 {"title": "Privacy Policy", "icon": Icons.privacy_tip_outlined},
//                 {
//                   "title": "Delete Account",
//                   "icon": Icons.delete_forever_sharp,
//                   "page": const DeleteUserAccount()
//                 },
//                 {"title": "Logout", "icon": Icons.logout},
//               ];
//               return RefreshIndicator(
//                 onRefresh: _reFetchData,
//                 child: CustomScrollView(
//                   slivers: [
//                     customSliverAppbar(
//                       expandedHeight: size.height * 0.2,
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Profile Settings",
//                               style: AppStyle.medium_18(AppColors.themeColor)),
//                           Stack(
//                             alignment: Alignment.topRight,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 15, right: 5),
//                                 child: GestureDetector(
//                                   // onTap: () => AppRouter().navigateTo(
//                                   //     context, const NotificationScreen()),
//                                   child: CircleAvatar(
//                                     backgroundColor: AppColors.theme10,
//                                     child: const Icon(
//                                       Icons.notifications,
//                                       color: AppColors.themeColor,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // BlocBuilder<NotificationsBloc, NotificationsState>(
//                               //     builder: (context, state) {
//                               //       if (state is NotificationsSuccess) {
//                               //         final user = state.getNotificationModel.data;
//                               //         return user!.unread ==0
//                               //             ? SizedBox()
//                               //             :
//
//                               CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: AppColors.redColor,
//                                 child: Text(
//                                   '12+',
//                                   style:
//                                       AppStyle.normal_10(AppColors.whiteColor),
//                                 ),
//                               )
//
//                               // ;
//                               //   } else {
//                               //     return SizedBox();
//                               //   }
//                               // })
//                             ],
//                           )
//                         ],
//                       ),
//                       flexibleSpace: LayoutBuilder(
//                         builder: (context, constraints) {
//                           var percent =
//                               ((constraints.maxHeight - kToolbarHeight) /
//                                       (size.height * 0.2 - kToolbarHeight))
//                                   .clamp(0.0, 1.0);
//
//                           return FlexibleSpaceBar(
//                             collapseMode: CollapseMode.parallax,
//                             background: Container(color: AppColors.theme5),
//                             titlePadding: EdgeInsets.zero,
//                             title: percent > 0.5
//                                 ? Opacity(
//                                     opacity: percent,
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(
//                                           horizontal: size.width * 0.02),
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: size.width * 0.01,
//                                           vertical: size.height * 0.014),
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: AppColors.theme5),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(100),
//                                               child: SizedBox(
//                                                   height: 50,
//                                                   width: 50,
//                                                   child: profilePickImage(
//                                                       profile!.avatar! ?? ''))),
//                                           const SizedBox(width: 2),
//                                           // Text section
//                                           Expanded(
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 5),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Flexible(
//                                                     child: Text(
//                                                       profile.name ?? '',
//                                                       style:
//                                                           AppStyle.semiBold_14(
//                                                               AppColors
//                                                                   .blackColor),
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "+91 ${profile!.phone.toString()}",
//                                                     style: AppStyle.normal_10(
//                                                         AppColors.black20),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : const SizedBox(),
//                           );
//                         },
//                       ),
//                     ),
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) => Align(
//                           alignment: Alignment.center,
//                           child: settingsWidget(
//                               onTap: () {
//                                 if (index != 5) {
//                                   AppRouter().navigateTo(
//                                       context, settingTitles[index]['page']);
//                                 } else {
//                                   logOutPermissionDialog(context);
//                                 }
//                               },
//                               title: settingTitles[index]['title'],
//                               icon: settingTitles[index]['icon']),
//                         ),
//                         childCount: settingTitles.length,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return const SizedBox();
//             }
//           },
//         ),
//       ),
//       // ),
//       // ),
//     );
//   }
// }
//
//
//
//

import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_state.dart';
import 'package:market_place_customer/data/models/profile_model.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/already_purchesed_dialog.dart';

import '../../utils/exports.dart';

class SettingsPageUiPage extends StatefulWidget {
  const SettingsPageUiPage({super.key});

  @override
  State<SettingsPageUiPage> createState() => _SettingsPageUiPageState();
}

class _SettingsPageUiPageState extends State<SettingsPageUiPage> {
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
    return Scaffold(
      body: BlocBuilder<FetchProfileDetailsBloc, FetchProfileDetailsState>(
        builder: (context, state) {
          if (state is FetchProfileDetailsLoading) {
            return SingleChildScrollView(child: profileSimmerLoading());
          } else if (state is FetchProfileDetailsFailure) {
            return Center(
                child: Text(state.error.toString(),
                    style: AppStyle.medium_14(AppColors.redColor)));
          } else if (state is FetchProfileDetailsSuccess) {
            final profile = state.profileModel.customerProfileData;

            // /// Map fetched data to local model
            // merchantRegistrationModel = MerchantRegistrationModel(
            //   name: businessProfile.vendor?.name ?? '',
            //   mobile: businessProfile.vendor?.phone.toString() ?? '',
            //   email: businessProfile.vendor?.email ?? '',
            //   businessName:
            //   businessProfile.businessDetails?.businessName ?? '',
            //   businessRegistrationNo:
            //   businessProfile.businessDetails?.businessRegister ?? '',
            //   gstNumber: businessProfile.businessDetails?.gstNumber ?? '',
            //   state: businessProfile.businessDetails?.state ?? '',
            //   city: businessProfile.businessDetails?.city ?? '',
            //   address: businessProfile.businessDetails?.address ?? '',
            //   businessLogo: businessProfile.document?.businessLogo ?? '',
            //   businessImages:
            //   businessProfile.businessDetails?.businessImage ?? [],
            // );

            /// Settings List
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
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _customAppHeader(profile),
                  SliverList.builder(
                    itemCount: settingTitles.length,
                    itemBuilder: (context, index) {
                      final item = settingTitles[index];
                      return _settingsTile(
                        title: item["title"],
                        icon: item["icon"],
                        onTap: () {
                          if (index != settingTitles.length - 1) {
                            if (item["page"] != null) {
                              AppRouter().navigateTo(context, item["page"]);
                            }
                          } else {
                            logOutPermissionDialog(context);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// Modern App Header
  SliverAppBar _customAppHeader(CustomerProfileData? profileData) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: size.height * 0.12,
      backgroundColor: Colors.indigo,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3949ab), Color(0xff5c6bc0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        profileData!.avatar ?? '',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) =>
                            const Icon(Icons.storefront, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profileData.name ?? "Hi ",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(
                          "+91 ${profileData.phone}",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: GestureDetector(
                          // onTap: () => AppRouter().navigateTo(
                          //     context, const NotificationScreen()),
                          child: const CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
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
                          style: AppStyle.normal_10(AppColors.whiteColor),
                        ),
                      )

                      // ;
                      //   } else {
                      //     return SizedBox();
                      //   }
                      // })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Modern Settings Tile
  Widget _settingsTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: size.width * 0.022),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        leading: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.themeColor.withOpacity(0.1),
            child: Icon(icon, color: AppColors.themeColor)),
        title: Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            color: Colors.black38, size: 18),
      ),
    );
  }
}
