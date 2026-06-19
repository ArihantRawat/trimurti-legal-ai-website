import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../core/contact/contact_service.dart';
import '../../core/motion/motion.dart';
import '../../core/responsive/breakpoints.dart';
import 'home_anchors.dart';
import 'widgets/ambient_background.dart';
import 'widgets/home_content.dart';
import 'widgets/intro_splash.dart';
import 'widgets/site_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _anchors = HomeAnchors();

  Offset _pointer = const Offset(0.5, 0.32);
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    final next = _scrollController.hasClients && _scrollController.offset > 18;
    if (next != _scrolled) setState(() => _scrolled = next);
  }

  void _updatePointer(PointerHoverEvent event) {
    final size = MediaQuery.sizeOf(context);
    if (size.width == 0 || size.height == 0) return;
    setState(() {
      _pointer = Offset(
        (event.position.dx / size.width).clamp(0, 1),
        (event.position.dy / size.height).clamp(0, 1),
      );
    });
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: Motion.duration(context, 720),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  void _contactTrimurti() {
    unawaited(ContactService.openContactEmail());
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return Scaffold(
      body: MouseRegion(
        onHover: _updatePointer,
        child: Stack(
          children: [
            Positioned.fill(child: AmbientBackground(pointer: _pointer)),
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  toolbarHeight: mobile ? 68 : 78,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ConstrainedPage(
                      child: SiteNavBar(
                        scrolled: _scrolled,
                        onHero: () => _scrollTo(_anchors.hero),
                        onProduct: () => _scrollTo(_anchors.vision),
                        onSecurity: () => _scrollTo(_anchors.security),
                        onFaq: () => _scrollTo(_anchors.faq),
                        onContact: _contactTrimurti,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HomeContent(
                    revealController: _scrollController,
                    anchors: _anchors,
                    onContact: _contactTrimurti,
                    onScrollTo: _scrollTo,
                  ),
                ),
              ],
            ),
            const Positioned.fill(child: IntroSplash()),
          ],
        ),
      ),
    );
  }
}
