// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:market_place_customer/utils/custom_appbar.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PrivacyPolicy extends StatelessWidget {
//   const PrivacyPolicy({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppbar(title: "Privacy Policy"),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }
//
// WebViewController controller = WebViewController()
//   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   ..setNavigationDelegate(
//     NavigationDelegate(
//       onProgress: (int progress) {
//         EasyLoading.show(status: 'Loading...');
//       },
//       onPageStarted: (String url) {
//         EasyLoading.dismiss();
//       },
//       onPageFinished: (String url) {
//         EasyLoading.dismiss();
//       },
//       onHttpError: (HttpResponseError error) {
//         EasyLoading.dismiss();
//       },
//       onWebResourceError: (WebResourceError error) {
//         EasyLoading.dismiss();
//       },
//       onNavigationRequest: (NavigationRequest request) {
//         if (request.url
//             .startsWith('https://transapi.fpdemo.com/api/privacy/policy')) {
//           return NavigationDecision.prevent;
//         }
//         return NavigationDecision.navigate;
//       },
//     ),
//   )
//   ..loadRequest(Uri.parse('https://transapi.fpdemo.com/api/privacy/policy'));
