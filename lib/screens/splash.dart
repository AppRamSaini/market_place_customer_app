import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_customer/screens/auth/get_started.dart';
import 'package:market_place_customer/utils/exports.dart';

import '../bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    // Fetch business categories
    context.read<BusinessCategoryCubit>().fetchBusinessCategory();

    // Get stored token and role
    String? token = LocalStorage.getString(Pref.token);
    String? role = LocalStorage.getString(Pref.roleType);
   await LocalStorage.setString(Pref.location,"Devi Marg, Bani Park, Jaipur - 302006, Rajasthan, India");

    // Optional: debug prints
    print('TOKEN==>>$token');
    print('ROLE==>>$role');

    context
        .read<FetchDashboardOffersBloc>()
        .add(DashboardOffersEvent(context: context));
    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (token != null && role != null) {
        AppRouter().navigateAndClearStack(context, const CustomerDashboard());
      } else {
        AppRouter().navigateAndClearStack(context, const DetectLocation());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Added for size reference
    return Scaffold(
      body: Image.asset(
        Assets.logoGIF,
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
