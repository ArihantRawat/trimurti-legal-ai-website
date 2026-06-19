import 'package:flutter/widgets.dart';

enum ScreenSize { mobile, tablet, desktop }

class Breakpoints {
  static const double mobile = 720;
  static const double tablet = 1060;
  static const double maxWidth = 1180;

  static ScreenSize of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobile) return ScreenSize.mobile;
    if (width < tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  static bool isMobile(BuildContext context) =>
      of(context) == ScreenSize.mobile;
  static bool isTablet(BuildContext context) =>
      of(context) == ScreenSize.tablet;
  static bool isDesktop(BuildContext context) =>
      of(context) == ScreenSize.desktop;

  static EdgeInsets pagePadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobile) return const EdgeInsets.symmetric(horizontal: 18);
    if (width < tablet) return const EdgeInsets.symmetric(horizontal: 32);
    return const EdgeInsets.symmetric(horizontal: 40);
  }
}

class ConstrainedPage extends StatelessWidget {
  const ConstrainedPage({
    required this.child,
    this.maxWidth = Breakpoints.maxWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Breakpoints.pagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
