import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  void openUrl(String url);
}

class UrlLauncher extends UrlHandler {
  @override
  void openUrl(String url) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
