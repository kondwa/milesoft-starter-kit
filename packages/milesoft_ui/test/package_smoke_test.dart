import 'package:flutter/widgets.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show MaterialApp;
import 'package:milesoft_ui/milesoft_ui.dart' as ui;

void main() {
  test('public theme types are compatible with standalone Material', () {
    final ui.ColorScheme colors = ui.ColorScheme.fromSeed(
      seedColor: const Color(0xFF336699),
    );
    const ui.TextTheme typography = ui.TextTheme();
    final theme = ui.ThemeData(colorScheme: colors, textTheme: typography);
    final app = MaterialApp(theme: theme, themeMode: ui.ThemeMode.dark);

    expect(app.theme, same(theme));
    expect(app.themeMode, ui.ThemeMode.dark);
  });
}
