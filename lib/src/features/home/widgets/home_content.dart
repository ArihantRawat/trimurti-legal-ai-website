import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../home_anchors.dart';
import '../home_config.dart';
import '../sections/cta_footer_sections.dart';
import '../sections/feature_sections.dart';
import '../sections/principle_carousel_section.dart';
import '../sections/process_section.dart';
import '../sections/product_sections.dart';
import '../sections/security_section.dart';
import '../sections/use_case_rail_section.dart';
import 'announcement_banner.dart';
import 'faq_section.dart';
import 'hero_section.dart';
import 'product_vision_section.dart';
import 'trust_bar.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    required this.revealController,
    required this.anchors,
    required this.onContact,
    required this.onScrollTo,
    super.key,
  });

  final ScrollController revealController;
  final HomeAnchors anchors;
  final VoidCallback onContact;
  final void Function(GlobalKey key) onScrollTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnnouncementBanner(onContact: onContact),
        KeyedSubtree(
          key: anchors.hero,
          child: HeroSection(
            onContact: onContact,
            onExplore: () => onScrollTo(anchors.vision),
          ),
        ),
        RevealOnScroll(controller: revealController, child: const TrustBar()),
        RevealOnScroll(
          controller: revealController,
          child: UseCaseRailSection(onContact: onContact),
        ),
        RevealOnScroll(
          controller: revealController,
          child: KeyedSubtree(
            key: anchors.vision,
            child: const ProductVisionSection(),
          ),
        ),
        RevealOnScroll(
          controller: revealController,
          child: const PrincipleCarouselSection(),
        ),
        if (HomeConfig.showDetailedSections) ...[
          RevealOnScroll(
            controller: revealController,
            child: const WhyTrimurtiSection(),
          ),
          RevealOnScroll(
            controller: revealController,
            child: KeyedSubtree(
              key: anchors.workflow,
              child: const WorkflowSection(),
            ),
          ),
          RevealOnScroll(
            controller: revealController,
            child: KeyedSubtree(
              key: anchors.research,
              child: const ResearchSection(),
            ),
          ),
        ],
        RevealOnScroll(
          controller: revealController,
          child: KeyedSubtree(
            key: anchors.security,
            child: const SecuritySection(),
          ),
        ),
        if (HomeConfig.showDetailedSections)
          RevealOnScroll(
            controller: revealController,
            child: const HowItWorksSection(),
          ),
        RevealOnScroll(
          controller: revealController,
          child: KeyedSubtree(key: anchors.faq, child: const FaqSection()),
        ),
        RevealOnScroll(
          controller: revealController,
          child: KeyedSubtree(
            key: anchors.cta,
            child: FinalCtaSection(onContact: onContact),
          ),
        ),
        FooterSection(
          onAbout: () => onScrollTo(anchors.hero),
          onContact: onContact,
          onWorkflow: () => onScrollTo(anchors.workflowTarget),
          onResearch: () => onScrollTo(anchors.researchTarget),
          onFaq: () => onScrollTo(anchors.faq),
          onSecurity: () => onScrollTo(anchors.security),
        ),
      ],
    );
  }
}
