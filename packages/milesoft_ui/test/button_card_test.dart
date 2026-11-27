import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

void main() {
  testWidgets(
    'keyboard activates an enabled button and loading blocks activation',
    (tester) async {
      var calls = 0;

      Future<void> show({required bool loading, required bool enabled}) =>
          tester.pumpWidget(
            MaterialApp(
              theme: MileSoftTheme.build(),
              home: Scaffold(
                body: MileSoftButton(
                  label: 'Save',
                  onPressed: enabled ? () => calls++ : null,
                  loading: loading,
                  loadingLabel: 'Saving',
                ),
              ),
            ),
          );

      await show(loading: false, enabled: true);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(calls, 1);

      await show(loading: true, enabled: true);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      await tester.tapAt(tester.getCenter(find.text('Save')));
      await tester.pump();
      expect(calls, 1);

      await show(loading: false, enabled: false);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    },
  );

  testWidgets('button variants use their native Material controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              for (final variant in MileSoftButtonVariant.values)
                MileSoftButton(
                  label: variant.name,
                  variant: variant,
                  onPressed: () {},
                ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(FilledButton), findsNWidgets(2));
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('card variants use semantic surfaces and an outline', (
    tester,
  ) async {
    final colors = ColorScheme.fromSeed(seedColor: const Color(0xFF168068));
    await tester.pumpWidget(
      MaterialApp(
        theme: MileSoftTheme.build(colorOverrides: colors),
        home: const Scaffold(
          body: Column(
            children: [
              MileSoftCard(child: Text('Elevated')),
              MileSoftCard(
                variant: MileSoftCardVariant.filled,
                child: Text('Filled'),
              ),
              MileSoftCard(
                variant: MileSoftCardVariant.outlined,
                child: Text('Outlined'),
              ),
            ],
          ),
        ),
      ),
    );

    final cards = tester.widgetList<Card>(find.byType(Card)).toList();
    expect(cards, hasLength(3));
    expect(cards[1].color, colors.surfaceContainerHighest);
    expect(cards[1].elevation, MileSoftTokens.elevation.flat);
    expect(
      (cards[2].shape as RoundedRectangleBorder).side.color,
      colors.outlineVariant,
    );
  });
}
