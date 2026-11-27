import 'package:flutter/widgets.dart'
    show Brightness, Color, TextStyle, FontWeight;
import 'package:flutter_test/flutter_test.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

double contrast(Color first, Color second) {
  final a = first.computeLuminance();
  final b = second.computeLuminance();
  return a > b ? (a + 0.05) / (b + 0.05) : (b + 0.05) / (a + 0.05);
}

void main() {
  test('the approved scales are ordered and match the token values', () {
    final spacing = MileSoftTokens.spacing;
    final radius = MileSoftTokens.radius;
    final elevation = MileSoftTokens.elevation;

    expect(
      [
        spacing.xSmall,
        spacing.small,
        spacing.medium,
        spacing.large,
        spacing.xLarge,
      ],
      [4, 8, 16, 24, 32],
    );
    expect([radius.small, radius.medium, radius.large], [4, 8, 16]);
    expect([elevation.flat, elevation.low, elevation.raised], [0, 1, 3]);
  });

  for (final brightness in Brightness.values) {
    test(
      'defaults derive from the provisional seed and meet contrast in $brightness',
      () {
        final tokens = MileSoftTokens(brightness: brightness);
        final colors = tokens.colorScheme;
        final expected = ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: brightness,
        );

        expect(colors, expected);
        expect(colors.brightness, brightness);
        expect(tokens.textTheme.bodyMedium, isNotNull);
        expect(tokens.textTheme.titleLarge, isNotNull);
        for (final (foreground, background) in [
          (colors.onPrimary, colors.primary),
          (colors.onSurface, colors.surface),
          (colors.onError, colors.error),
          (colors.onSecondary, colors.secondary),
        ]) {
          expect(contrast(foreground, background), greaterThanOrEqualTo(4.5));
        }
      },
    );
  }

  test('each mode accepts product colors and partial typography overrides', () {
    final colors = ColorScheme.fromSeed(
      seedColor: const Color(0xFF168068),
      brightness: Brightness.dark,
    );
    const type = TextTheme(bodyMedium: TextStyle(fontWeight: FontWeight.bold));
    final customised = MileSoftTokens(
      brightness: Brightness.dark,
      colorOverrides: colors,
      typographyOverrides: type,
    );
    final defaultsForProductColors = ThemeData(colorScheme: colors).textTheme;
    final light = MileSoftTokens();

    expect(customised.colorScheme, same(colors));
    expect(customised.textTheme.bodyMedium?.fontWeight, FontWeight.bold);
    expect(
      customised.textTheme.titleLarge,
      defaultsForProductColors.titleLarge,
    );
    expect(light.colorScheme.brightness, Brightness.light);
    expect(light.colorScheme, isNot(colors));
  });
}
