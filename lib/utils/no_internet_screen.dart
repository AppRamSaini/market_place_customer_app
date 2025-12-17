import 'package:market_place_customer/utils/exports.dart';

class NoInternetPage extends StatefulWidget {
  final VoidCallback onRetry;

  const NoInternetPage({super.key, required this.onRetry});

  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey.shade900]
                : [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 Animated Wi-Fi Icon
            ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.1).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: const Icon(Icons.wifi_off_rounded,
                    size: 120, color: AppColors.themeColor)),

            const SizedBox(height: 20),

            // 🔥 Title
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Please check your network settings. "
                "Your device is currently offline.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 30),
            CustomButtons.rounded(text: "Retry", onPressed: widget.onRetry),

            const SizedBox(height: 40),

            // Tips
            Text(
              "Turn ON mobile data or Wi-Fi",
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white38 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
