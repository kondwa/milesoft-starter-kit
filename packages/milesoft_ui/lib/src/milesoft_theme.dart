import 'package:material_ui/material_ui.dart'
    show
        BorderRadius,
        Brightness,
        CardThemeData,
        ColorScheme,
        EdgeInsets,
        FilledButton,
        FilledButtonThemeData,
        InputDecorationThemeData,
        OutlineInputBorder,
        RoundedRectangleBorder,
        TextTheme,
        ThemeData;

import 'tokens.dart';

/// Builds Material 3 themes from MileSoft's semantic tokens.
///
/// Pass the light and dark variants to the consuming app and let that app
/// own theme mode selection, including following the system setting.
abstract final class MileSoftTheme {
  /// Builds a theme for [brightness] with optional product overrides.
  ///
  /// A product color scheme must match the requested brightness. Partial
  /// typography overrides merge into the Material defaults for that scheme.
  static ThemeData build({
    Brightness brightness = Brightness.light,
    ColorScheme? colorOverrides,
    TextTheme? typographyOverrides,
  }) {
    if (colorOverrides != null && colorOverrides.brightness != brightness) {
      throw ArgumentError.value(
        colorOverrides.brightness,
        'colorOverrides.brightness',
        'Must match the requested brightness',
      );
    }

    final tokens = MileSoftTokens(
      brightness: brightness,
      colorOverrides: colorOverrides,
      typographyOverrides: typographyOverrides,
    );
    final radius = BorderRadius.circular(MileSoftTokens.radius.medium);
    final shape = RoundedRectangleBorder(borderRadius: radius);

    return ThemeData(
      colorScheme: tokens.colorScheme,
      textTheme: tokens.textTheme,
      cardTheme: CardThemeData(
        color: tokens.colorScheme.surfaceContainerLow,
        elevation: MileSoftTokens.elevation.low,
        shape: shape,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: MileSoftTokens.spacing.medium,
          ),
          shape: shape,
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(borderRadius: radius),
      ),
    );
  }
}
