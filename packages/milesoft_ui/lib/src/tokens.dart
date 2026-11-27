import 'dart:ui' show Brightness, Color;

import 'package:material_ui/material_ui.dart'
    show ColorScheme, TextTheme, ThemeData;

/// Semantic Material 3 tokens for one brightness.
///
/// Products can supply their own semantic colors and typography for each mode.
/// The default seed is provisional.
final class MileSoftTokens {
  factory MileSoftTokens({
    Brightness brightness = Brightness.light,
    ColorScheme? colorOverrides,
    TextTheme? typographyOverrides,
  }) {
    final colors =
        colorOverrides ??
        ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
    final typography = ThemeData(colorScheme: colors).textTheme
        .merge(typographyOverrides);
    return MileSoftTokens._(colors, typography);
  }

  const MileSoftTokens._(this.colorScheme, this.textTheme);

  static const _seed = Color(0xFF2563EB);

  /// Spacing in logical pixels, from compact inset to section separation.
  static const spacing = (
    xSmall: 4.0,
    small: 8.0,
    medium: 16.0,
    large: 24.0,
    xLarge: 32.0,
  );

  /// Corner radii in logical pixels.
  static const radius = (small: 4.0, medium: 8.0, large: 16.0);

  /// Elevation in logical pixels.
  static const elevation = (flat: 0.0, low: 1.0, raised: 3.0);

  /// Roles such as primary/onPrimary and surface/onSurface.
  final ColorScheme colorScheme;

  /// Material 3 type roles with supplied product styles merged in.
  final TextTheme textTheme;
}
