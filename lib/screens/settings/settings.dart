import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import 'package:market_place_customer/screens/profile/profile.dart';
import 'package:market_place_customer/utils/exports.dart';

class SettingsPageUiPage extends StatefulWidget {
  const SettingsPageUiPage({super.key});

  @override
  State<SettingsPageUiPage> createState() => _SettingsPageUiPageState();
}

class _SettingsPageUiPageState extends State<SettingsPageUiPage> {
  CustomerRegistrationModel? customerRegistrationModel;

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

  /// Settings List
  List settingTitles = [
    {
      "title": "Update Profile",
      "icon": Icons.person,
      "page": const EditProfilePage()
    },
    {
      "title": "Help & Support",
      "icon": Icons.info_outline_rounded,
      "page": const HelpSupportPage()
    },
    {
      "title": "Terms & Conditions",
      "icon": Icons.gavel,
      "page": const TermsAndConditions()
    },
    {
      "title": "Privacy Policy",
      "icon": Icons.privacy_tip_outlined,
      "page": const PrivacyPolicyScreen()
    },
    {
      "title": "Delete Account",
      "icon": Icons.delete_forever_sharp,
      "page": const DeleteUserAccount()
    },
    {"title": "Logout", "icon": Icons.logout},
  ];

  /// new code
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) _reFetchData();
          },
        )
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _reFetchData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const CustomerProfile(),
              SliverList.builder(
                itemCount: settingTitles.length,
                itemBuilder: (context, index) {
                  final item = settingTitles[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + (index * 60)),
                    child: settingsTile(
                      title: item["title"],
                      icon: item["icon"],
                      onTap: () {
                        if (index != settingTitles.length - 1) {
                          if (item["page"] != null) {
                            AppRouter().navigateTo(context, item["page"]);
                          }
                        } else {
                          showLogoutPermissionDialog(context, onConfirm: () {
                            EasyLoading.show();
                            Future.delayed(const Duration(seconds: 2), () {
                              EasyLoading.dismiss();
                              LocalStorage.clearAll(context);
                            });
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
