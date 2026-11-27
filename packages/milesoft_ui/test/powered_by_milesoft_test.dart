import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

void main() {
  testWidgets('fallback is text with one accessible attribution label', (
    tester,
  ) async {
    const label = 'Powered by MileSoft';
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PoweredByMileSoft(label: label)),
      ),
    );

    final attribution = find.byType(PoweredByMileSoft);
    expect(
      find.descendant(of: attribution, matching: find.text(label)),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel(label), findsOneWidget);
    expect(
      find.descendant(of: attribution, matching: find.byType(Image)),
      findsNothing,
    );
  });

  testWidgets('attribution remains in bounds at 200 percent text scaling', (
    tester,
  ) async {
    const label = 'Powered by MileSoft';
    tester.view.physicalSize = const Size(320, 240);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: const Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 144,
                  child: PoweredByMileSoft(label: label),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final text = find.text(label);
    expect(tester.getSize(text).width, lessThanOrEqualTo(144));
    expect(tester.getSize(text).height, greaterThan(24));
    expect(text.hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses readable surface text in light and dark product themes', (
    tester,
  ) async {
    const label = 'Powered by MileSoft';

    for (final brightness in Brightness.values) {
      final scheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF168068),
        brightness: brightness,
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: MileSoftTheme.build(
            brightness: brightness,
            colorOverrides: scheme,
          ),
          home: const Scaffold(body: PoweredByMileSoft(label: label)),
        ),
      );
      await tester.pumpAndSettle();

      final color = tester.widget<Text>(find.text(label)).style!.color!;
      expect(color, scheme.onSurface);
      final luminances = [
        color.computeLuminance(),
        scheme.surface.computeLuminance(),
      ]..sort();
      expect(
        (luminances.last + 0.05) / (luminances.first + 0.05),
        greaterThanOrEqualTo(4.5),
      );
    }
  });
}
