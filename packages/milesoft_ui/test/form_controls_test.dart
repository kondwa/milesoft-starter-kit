import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

const _options = [
  (value: 'email', label: 'Email'),
  (value: 'sms', label: 'SMS'),
];

Widget _form(GlobalKey<FormState> key, Widget child) => MaterialApp(
  theme: MileSoftTheme.build(),
  home: Scaffold(
    body: Form(key: key, child: child),
  ),
);

void main() {
  testWidgets('checkbox validates, toggles by keyboard and resets', (
    tester,
  ) async {
    final form = GlobalKey<FormState>();
    final changes = <bool>[];
    await tester.pumpWidget(
      _form(
        form,
        MileSoftCheckbox(
          label: 'Accept terms',
          validator: (value) => value == true ? null : 'Accept the terms',
          onChanged: changes.add,
        ),
      ),
    );

    expect(find.bySemanticsLabel('Accept terms'), findsOneWidget);
    expect(form.currentState!.validate(), isFalse);
    await tester.pumpAndSettle();
    expect(find.text('Accept the terms'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(changes, [true]);
    expect(form.currentState!.validate(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Accept the terms'), findsNothing);

    form.currentState!.reset();
    await tester.pumpAndSettle();
    expect(
      tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
      isFalse,
    );
  });

  testWidgets('switch respects disabled state and reports enabled changes', (
    tester,
  ) async {
    final form = GlobalKey<FormState>();
    final changes = <bool>[];
    Widget app({required bool enabled}) => _form(
      form,
      MileSoftSwitch(
        label: 'Enable previews',
        enabled: enabled,
        onChanged: changes.add,
        validator: (value) =>
            value == true ? null : 'Enable previews to continue',
      ),
    );

    await tester.pumpWidget(app(enabled: false));
    expect(find.bySemanticsLabel('Enable previews'), findsOneWidget);
    await tester.tapAt(tester.getCenter(find.text('Enable previews')));
    await tester.pumpAndSettle();
    expect(changes, isEmpty);

    await tester.pumpWidget(app(enabled: true));
    expect(form.currentState!.validate(), isFalse);
    await tester.pumpAndSettle();
    expect(find.text('Enable previews to continue'), findsOneWidget);
    await tester.tap(find.text('Enable previews'));
    await tester.pumpAndSettle();
    expect(changes, [true]);
    expect(form.currentState!.validate(), isTrue);
  });

  testWidgets(
    'radio group exposes its name and navigates choices with arrows',
    (tester) async {
      final form = GlobalKey<FormState>();
      final changes = <String?>[];
      await tester.pumpWidget(
        _form(
          form,
          MileSoftRadioGroup<String>(
            label: 'Delivery channel',
            options: _options,
            initialValue: 'email',
            onChanged: changes.add,
          ),
        ),
      );

      expect(find.bySemanticsLabel(RegExp('Delivery channel')), findsWidgets);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(changes, ['sms']);
    },
  );

  testWidgets('dropdown shows validation and reports a selected value', (
    tester,
  ) async {
    final form = GlobalKey<FormState>();
    final changes = <String?>[];
    await tester.pumpWidget(
      _form(
        form,
        MileSoftDropdown<String>(
          label: 'Delivery channel',
          options: _options,
          validator: (value) => value == null ? 'Choose a channel' : null,
          onChanged: changes.add,
        ),
      ),
    );

    expect(find.bySemanticsLabel(RegExp('Delivery channel')), findsWidgets);
    expect(form.currentState!.validate(), isFalse);
    await tester.pumpAndSettle();
    expect(find.text('Choose a channel'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SMS').last);
    await tester.pumpAndSettle();
    expect(changes, ['sms']);
    expect(form.currentState!.validate(), isTrue);
  });
}
