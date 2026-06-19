import 'package:flutter/widgets.dart';

import 'home_config.dart';

class HomeAnchors {
  final hero = GlobalKey();
  final vision = GlobalKey();
  final workflow = GlobalKey();
  final research = GlobalKey();
  final security = GlobalKey();
  final faq = GlobalKey();
  final cta = GlobalKey();

  GlobalKey get workflowTarget =>
      HomeConfig.showDetailedSections ? workflow : vision;

  GlobalKey get researchTarget =>
      HomeConfig.showDetailedSections ? research : vision;
}
