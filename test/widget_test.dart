import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trimurti_marketing/src/core/contact/contact_service.dart';
import 'package:trimurti_marketing/src/app.dart';

void main() {
  testWidgets('renders Trimurti marketing homepage', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TrimurtiApp());

    expect(find.text('Trimurti'), findsWidgets);
    expect(
      find.text('The AI operating system for modern law firms'),
      findsOneWidget,
    );
    expect(find.text('Contact us'), findsWidgets);
    expect(find.text('View product vision'), findsOneWidget);
  });

  testWidgets('product vision uses stealth startup positioning', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TrimurtiApp());

    expect(
      find.text('One workspace for the legal work behind the work.'),
      findsOneWidget,
    );
    expect(find.text('Juridical Loop OS'), findsWidgets);
    expect(find.text('Operating layer for legal work'), findsWidgets);
    expect(find.text('Stealth by design'), findsWidgets);
  });

  testWidgets('renders mobile viewport without layout exceptions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TrimurtiApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(tester.takeException(), isNull);
  });

  test('contact email has the expected recipient and prefill', () {
    final uri = ContactService.contactUri;

    expect(uri.scheme, 'mailto');
    expect(uri.path, 'arihantrawat@gmail.com');
    expect(uri.queryParameters['subject'], 'Interested in Juridical Loop OS');
    expect(
      uri.queryParameters['body'],
      contains('We saw what you are building with Juridical Loop OS'),
    );
  });
}
