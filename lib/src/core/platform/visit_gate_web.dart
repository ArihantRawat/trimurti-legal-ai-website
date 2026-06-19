import 'package:web/web.dart' as web;

class VisitGate {
  static const _introKey = 'trimurti_intro_seen';

  static bool hasSeenIntro() {
    return web.window.sessionStorage.getItem(_introKey) == 'true';
  }

  static void markIntroSeen() {
    web.window.sessionStorage.setItem(_introKey, 'true');
  }
}
