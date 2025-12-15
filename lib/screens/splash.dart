import 'package:market_place_customer/utils/exports.dart';

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
    /// fetch the apis data
    fetchApiDataInSplash(context);

    /// Get stored token and role
    String? token = LocalStorage.getString(Pref.token);
    String? role = LocalStorage.getString(Pref.roleType);
    String? address = LocalStorage.getString(Pref.location);

    print('TOKEN==>>$token');
    print('ROLE==>>$role');
    print('ADD==>>$address');

    final locationService = LocationService();
    await locationService.fetchAndSaveCurrentLocation();

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () async {
      try {
        if (token != null) {
          AppRouter().navigateAndClearStack(context, const CustomerDashboard());
        } else {
          AppRouter().navigateAndClearStack(context, const LoginScreen());
        }
      } catch (e) {
        AppRouter().navigateAndClearStack(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
