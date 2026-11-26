import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:showcase/main.dart';

void main() {
  const label = 'MileSoft Starter Kit';

  testWidgets('displays the core-derived label with accessible semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(const ShowcaseApp());
      await tester.pumpAndSettle();

      expect(find.text(label), findsOneWidget);
      expect(find.bySemanticsLabel(label), findsOneWidget);
    } finally {
      semantics.dispose();
    }
  });

  for (final size in [const Size(320, 568), const Size(1280, 800)]) {
    testWidgets('keeps the scaled label in bounds at ${size.width}px', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const ShowcaseApp());
      await tester.pumpAndSettle();

      final text = find.text(label);
      expect(text, findsOneWidget);
      expect(MediaQuery.textScalerOf(tester.element(text)).scale(10), 20);
      final bounds = tester.getRect(text);
      expect(bounds.left, greaterThanOrEqualTo(0));
      expect(bounds.top, greaterThanOrEqualTo(0));
      expect(bounds.right, lessThanOrEqualTo(size.width));
      expect(bounds.bottom, lessThanOrEqualTo(size.height));
      expect(tester.takeException(), isNull);
    });
  }
}
