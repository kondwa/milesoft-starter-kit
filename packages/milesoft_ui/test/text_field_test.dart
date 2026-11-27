import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

Widget _app(Widget child) => MaterialApp(
  theme: MileSoftTheme.build(),
  home: Scaffold(body: child),
);

void main() {
  testWidgets('label is accessible and keyboard entry submits the value', (
    tester,
  ) async {
    final focus = FocusNode();
    addTearDown(focus.dispose);
    String? changed;
    String? submitted;

    await tester.pumpWidget(
      _app(
        MileSoftTextField(
          label: 'Email address',
          focusNode: focus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onChanged: (value) => changed = value,
          onSubmitted: (value) => submitted = value,
        ),
      ),
    );

    expect(find.bySemanticsLabel(RegExp('Email address')), findsWidgets);
    focus.requestFocus();
    await tester.pump();
    expect(focus.hasFocus, isTrue);
    await tester.enterText(find.byType(EditableText), 'test@example.invalid');
    expect(
      tester.testTextInput.setClientArgs?['inputType'],
      containsPair('name', 'TextInputType.emailAddress'),
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(changed, 'test@example.invalid');
    expect(submitted, 'test@example.invalid');
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows form validation and caller-supplied errors', (
    tester,
  ) async {
    final form = GlobalKey<FormState>();
    Widget field({String? errorText}) => _app(
      Form(
        key: form,
        child: MileSoftTextField(
          label: 'Name',
          errorText: errorText,
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter a name' : null,
        ),
      ),
    );

    await tester.pumpWidget(field());
    expect(form.currentState!.validate(), isFalse);
    await tester.pumpAndSettle();
    expect(find.text('Enter a name'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Ada');
    expect(form.currentState!.validate(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Enter a name'), findsNothing);

    await tester.pumpWidget(field(errorText: 'Choose a different name'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a different name'), findsOneWidget);
    expect(form.currentState!.validate(), isFalse);
  });

  testWidgets('disabled and read-only states prevent editing', (tester) async {
    final controller = TextEditingController(text: 'Original');
    addTearDown(controller.dispose);
    final focus = FocusNode();
    addTearDown(focus.dispose);
    Widget field({bool enabled = true, bool readOnly = false}) => _app(
      MileSoftTextField(
        label: 'Name',
        controller: controller,
        focusNode: focus,
        enabled: enabled,
        readOnly: readOnly,
      ),
    );

    await tester.pumpWidget(field(enabled: false));
    await tester.tapAt(tester.getCenter(find.byType(EditableText)));
    await tester.pumpAndSettle();
    expect(focus.hasFocus, isFalse);
    expect(tester.testTextInput.isVisible, isFalse);

    await tester.pumpWidget(field(readOnly: true));
    await tester.tap(find.byType(EditableText));
    await tester.pumpAndSettle();
    expect(focus.hasFocus, isTrue);
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).readOnly,
      isTrue,
    );
    expect(tester.testTextInput.isVisible, isFalse);
    expect(controller.text, 'Original');
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('unmounting preserves caller-owned controller and focus node', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    final focus = FocusNode();
    addTearDown(focus.dispose);

    await tester.pumpWidget(
      _app(
        MileSoftTextField(
          label: 'Name',
          controller: controller,
          focusNode: focus,
        ),
      ),
    );
    await tester.pumpWidget(const SizedBox());

    controller.text = 'Still usable';
    void listener() {}
    focus.addListener(listener);
    focus.removeListener(listener);
    expect(controller.text, 'Still usable');
  });
}
