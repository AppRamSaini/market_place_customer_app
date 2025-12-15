import 'package:market_place_customer/screens/dilogs/exit_page_dilog.dart';
import 'package:market_place_customer/screens/order_history/order_history_page.dart';

import '../../utils/exports.dart';

/// new update
class CustomerDashboard extends StatefulWidget {
  final int? selectedTabIndex;

  const CustomerDashboard({super.key, this.selectedTabIndex = 0});

  @override
  State<CustomerDashboard> createState() => CustomerDashboardState();
}

class CustomerDashboardState extends State<CustomerDashboard> {
  int currentIndex = 0;

  List pagesList = [
    const HomePage(),
    const PurchasedOffersHistory(),
    const OrderHistoryPage(),
    const SettingsPageUiPage(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() => currentIndex = widget.selectedTabIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        bool? shouldExit = await showExitConfirmationSheet(context);
        if (shouldExit != null && shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: pagesList[currentIndex],
        bottomNavigationBar: Padding(
          padding: globalBottomPadding(context),
          child: Container(
            decoration: BoxDecoration(color: AppColors.whiteColor, boxShadow: [
              BoxShadow(
                  color: AppColors.theme5.withOpacity(0.1), // subtle shadow
                  blurRadius: 10, // soft shadow
                  spreadRadius: 1,
                  offset: const Offset(0, -3))
            ]),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: currentIndex,
              onTap: (index) async {
                // Allow tap only on index 0 if user is NOT logged in
                if (index != 0) {
                  bool isLoggedIn = await checkedLogin(context);
                  if (!isLoggedIn) {
                    return; // Stop navigation
                  }
                }

                // If allowed, update bottom bar
                setState(() => currentIndex = index);
              },
              backgroundColor: AppColors.whiteColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.themeColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 22,
              selectedLabelStyle: AppStyle.medium_13(AppColors.themeColor),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_rounded), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer_rounded), label: "Offers"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded), label: "History"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
