import 'package:market_place_customer/screens/auth/get_started.dart';
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

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () async {
      try {
        final locationService = LocationService();
        await locationService.fetchAndSaveCurrentLocation();

        // Decide navigation
        if (token != null) {
          AppRouter().navigateAndClearStack(context, const CustomerDashboard());
        } else {
          AppRouter().navigateAndClearStack(context, const DetectLocation());
        }
      } catch (e) {
        AppRouter().navigateAndClearStack(context, const DetectLocation());
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

/*void showFloatingSnackbar(BuildContext context,
    {required String message, bool isError = false}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: 16,
      right: 16,
      bottom: 20,
      child: _FloatingSnackBar(
        message: message,
        isError: isError,
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
}

// 🔹 Floating Snackbar Widget
class _FloatingSnackBar extends StatefulWidget {
  final String message;
  final bool isError;

  const _FloatingSnackBar(
      {Key? key, required this.message, this.isError = false})
      : super(key: key);

  @override
  State<_FloatingSnackBar> createState() => _FloatingSnackBarState();
}

class _FloatingSnackBarState extends State<_FloatingSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _offset = Tween(begin: const Offset(0, 1.5), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isError ? Colors.redAccent : Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}*/
