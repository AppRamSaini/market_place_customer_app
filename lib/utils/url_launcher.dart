import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhone(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

Future<void> launchEmail({
  required String toEmail,
  String? subject,
}) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
// ···
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: toEmail,
    query: encodeQueryParameters(<String, String>{
      'subject':subject?? 'Example Subject & Symbols are allowed!',
    }),
  );

  launchUrl(emailLaunchUri);
}


