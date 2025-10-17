import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import 'package:market_place_customer/screens/payment_approval_request/payment_approval_request.dart';
import 'package:market_place_customer/screens/profile_and_settings/profile_and_settings.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:upgrader/upgrader.dart';
import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_event.dart';
import '../my_offers/my_offers_list.dart';


class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => CustomerDashboardState();
}

class CustomerDashboardState extends State<CustomerDashboard> {
  int currentIndex = 0;
  List pagesList = [
    HomePage(),
    MyOffersList(),
    ViewPaymentApprovalRequest(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    context.read<FetchProfileDetailsBloc>().add(FetchProfileEvent(context: context));
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
        onTap: () {
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
