import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart'
    show
        BorderRadius,
        Brightness,
        CardThemeData,
        Color,
        EdgeInsets,
        FontWeight,
        Key,
        MaterialApp,
        OutlineInputBorder,
        RoundedRectangleBorder,
        SizedBox,
        TextStyle,
        Theme;
import 'package:milesoft_ui/milesoft_ui.dart';

void main() {
  test('builds Material 3 themes with readable semantic colors', () {
    for (final brightness in Brightness.values) {
      final theme = MileSoftTheme.build(brightness: brightness);
      final scheme = theme.colorScheme;

      expect(theme.useMaterial3, isTrue);
      expect(scheme.brightness, brightness);
      final luminances = [
        scheme.onPrimary.computeLuminance(),
        scheme.primary.computeLuminance(),
      ]..sort();
      final contrast = (luminances.last + 0.05) / (luminances.first + 0.05);
      expect(contrast, greaterThanOrEqualTo(4.5));
    }
  });

  test('routes per-mode overrides and uses shared component tokens', () {
    for (final brightness in Brightness.values) {
      final colors = ColorScheme.fromSeed(
        seedColor: const Color(0xFF168068),
        brightness: brightness,
      );
      const typography = TextTheme(
        bodyMedium: TextStyle(fontWeight: FontWeight.bold),
      );
      final theme = MileSoftTheme.build(
        brightness: brightness,
        colorOverrides: colors,
        typographyOverrides: typography,
      );
      final CardThemeData card = theme.cardTheme;
      final button = theme.filledButtonTheme.style!;

      expect(theme.colorScheme, colors);
      expect(theme.textTheme.bodyMedium?.fontWeight, FontWeight.bold);
      expect(card.color, colors.surfaceContainerLow);
      expect(card.elevation, MileSoftTokens.elevation.low);
      expect(
        (card.shape as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(MileSoftTokens.radius.medium),
      );
      expect(
        button.padding!.resolve({}),
        EdgeInsets.symmetric(horizontal: MileSoftTokens.spacing.medium),
      );
      expect(
        (theme.inputDecorationTheme.border as OutlineInputBorder).borderRadius,
        BorderRadius.circular(MileSoftTokens.radius.medium),
      );
    }
  });

  test('rejects a scheme for a different brightness', () {
    final dark = MileSoftTokens(brightness: Brightness.dark).colorScheme;
    expect(
      () => MileSoftTheme.build(colorOverrides: dark),
      throwsArgumentError,
    );
  });

  testWidgets('the consuming app selects light, dark and host appearance', (
    tester,
  ) async {
    final dispatcher = tester.platformDispatcher;
    addTearDown(dispatcher.clearPlatformBrightnessTestValue);
    final light = MileSoftTheme.build();
    final dark = MileSoftTheme.build(brightness: Brightness.dark);
    const content = SizedBox(key: Key('theme-probe'));

    Future<void> select(ThemeMode mode) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: light,
          darkTheme: dark,
          themeMode: mode,
          home: content,
        ),
      );
      await tester.pumpAndSettle();
    }

    Brightness activeBrightness() =>
        Theme.of(tester.element(find.byWidget(content))).brightness;

    dispatcher.platformBrightnessTestValue = Brightness.dark;
    await select(ThemeMode.light);
    expect(activeBrightness(), Brightness.light);
    dispatcher.platformBrightnessTestValue = Brightness.light;
    await select(ThemeMode.dark);
    expect(activeBrightness(), Brightness.dark);

    await select(ThemeMode.system);
    expect(activeBrightness(), Brightness.light);
    dispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpAndSettle();
    expect(activeBrightness(), Brightness.dark);
  });
}
