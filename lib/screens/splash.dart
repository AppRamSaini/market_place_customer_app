import 'package:jwt_decode/jwt_decode.dart';
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

  bool checkTokenAndRedirect() {
    final token = LocalStorage.getString(Pref.token);

    // ---------------------------------------------------
    // 🔹 CASE 1: Token NULL ya EMPTY → direct redirect
    // ---------------------------------------------------
    if (token == null || token.isEmpty) {
      AppRouter().navigateAndClearStack(context, LoginScreen());
      return true;
    }
    bool isExpired = false;
    try {
      isExpired = Jwt.isExpired(token);
    } catch (e) {
      isExpired = true;
    }

    if (isExpired) {
      AppRouter().navigateAndClearStack(context, LoginScreen());
      return true;
    }
    return false;
  }

  void _startTimer() async {
    /// fetch the apis data
    fetchApiDataInSplash(context);

    /// Get stored token and role
    String? token = LocalStorage.getString(Pref.token);
    String? address = LocalStorage.getString(Pref.location);

    print('TOKEN==>>$token');
    print('ADD==>>$address');

    final locationService = LocationService();
    await locationService.fetchAndSaveCurrentLocation();

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () async {
      bool shouldStop = checkTokenAndRedirect();
      if (shouldStop) return;

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
