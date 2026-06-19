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
    expect(find.text('Legal work, with more clarity'), findsOneWidget);
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

    expect(find.text('What we are building first.'), findsOneWidget);
    expect(find.text('Juridical Loop OS'), findsWidgets);
    expect(find.text('A legal AI workspace in progress'), findsWidgets);
    expect(find.text('Stealth by design'), findsOneWidget);
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
