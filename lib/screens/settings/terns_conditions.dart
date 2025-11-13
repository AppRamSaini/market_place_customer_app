import 'package:market_place_customer/utils/exports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    /// Platform config
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            snackBar(context, "Failed to load content", AppColors.redColor);
          },

          /// ✅ URL Navigation Logic (Android + iOS)
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            // Open Play Store / External Links in Browser
            if (url.startsWith("https://play.google.com") ||
                url.startsWith("market://") ||
                url.startsWith("tel:") ||
                url.startsWith("mailto:") ||
                url.startsWith("whatsapp:")) {
              launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }

            // Allow Privacy Policy URL to load inside WebView
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiEndPoints.termsPolicyPage));

    /// Android-specific settings
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Terms & Conditions", context: context),
      body: Stack(
        children: [
          /// WebView with fade animation
          AnimatedOpacity(
            opacity: isLoading ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: WebViewWidget(controller: _controller),
          ),

          /// Loader over WebView
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        "Loading Terms & conditions policy...",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
