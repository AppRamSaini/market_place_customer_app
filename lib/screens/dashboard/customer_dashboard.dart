import 'package:market_place_customer/screens/order_history/order_history_page.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/already_purchesed_dialog.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:upgrader/upgrader.dart';

import '../../bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';

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

  fetchData() {
    var token = LocalStorage.getString(Pref.token);
    if (token != null) {
      context
          .read<PurchasedOffersHistoryBloc>()
          .add(GetPurchasedOffersHistoryEvent(context: context));
      context
          .read<FetchProfileDetailsBloc>()
          .add(FetchProfileEvent(context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        body: pagesList[currentIndex],
        bottomNavigationBar: Padding(
          padding: globalBottomPadding(context),
          child: Container(
            width: size.width,
            height: size.height * 0.065,
            decoration: BoxDecoration(color: AppColors.theme5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                dataList.length,
                (index) => _tabWidget(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List dataList = [
    {"icon": Icons.home, "value": "Home"},
    {"icon": Icons.local_offer_rounded, "value": "Offers"},
    {"icon": Icons.history_rounded, "value": "Oder History"},
    {"icon": Icons.person, "value": "Profile"}
  ];

  Widget _tabWidget(int index) => GestureDetector(
        onTap: () async {
          if (index == 1 || index == 3) {
            bool isLoggedIn = await checkedLogin(context);
            if (!isLoggedIn) return;
          }
          setState(() {
            currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: currentIndex == index
                  ? AppColors.theme20
                  : AppColors.transparent),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Icon(dataList[index]['icon'],
                  color: currentIndex == index
                      ? AppColors.themeColor
                      : AppColors.blackColor,
                  size: 22),
              const SizedBox(width: 8),
              currentIndex == index
                  ? Text(dataList[index]['value'].toString().toUpperCase(),
                      style: AppStyle.medium_12(currentIndex == index
                          ? AppColors.themeColor
                          : AppColors.blackColor))
                  : const SizedBox()
            ],
          ),
        ),
      );
}
