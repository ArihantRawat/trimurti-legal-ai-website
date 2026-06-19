import 'package:url_launcher/url_launcher.dart';

class ContactService {
  static final Uri contactUri = Uri(
    scheme: 'mailto',
    path: 'arihantrawat@gmail.com',
    queryParameters: {
      'subject': 'Interested in Juridical Loop OS',
      'body': '''
Hi Trimurti team,

We saw what you are building with Juridical Loop OS and would like to learn more. We are interested in understanding how it could help our legal team draft faster, research smarter, and work with greater confidence.

Additional context:

''',
    },
  );

  static Future<bool> openContactEmail() async {
    try {
      return launchUrl(contactUri, mode: LaunchMode.externalApplication);
    } on Object {
      return false;
    }
  }
}
