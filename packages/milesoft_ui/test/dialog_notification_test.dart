import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

void main() {
  testWidgets('a dismissible dialog takes focus and restores it after Escape', (
    tester,
  ) async {
    final triggerFocus = FocusNode();
    final actionFocus = FocusNode();
    addTearDown(triggerFocus.dispose);
    addTearDown(actionFocus.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              focusNode: triggerFocus,
              autofocus: true,
              onPressed: () => MileSoftDialog.show<void>(
                context,
                dismissible: true,
                builder: (dialogContext) => MileSoftDialog(
                  title: 'Details',
                  content: const Text('Example'),
                  actions: [
                    TextButton(
                      focusNode: actionFocus,
                      autofocus: true,
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(triggerFocus.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(actionFocus.hasFocus, isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Details'), findsNothing);
    expect(triggerFocus.hasFocus, isTrue);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'dialog blocks incidental dismissal and returns the action result',
    (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  result = await MileSoftDialog.show<bool>(
                    context,
                    builder: (dialogContext) => MileSoftDialog(
                      title: 'Confirm change',
                      content: const Text('Review the change first.'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Confirm change'), findsOneWidget);
      await tester.tapAt(const Offset(5, 5));
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Confirm change'), findsOneWidget);

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(find.text('Confirm change'), findsNothing);
      expect(result, isTrue);
    },
  );

  testWidgets(
    'the notification presents caller-localised accessible feedback',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => MileSoftNotification.show(
                  context,
                  message: 'Changes saved',
                ),
                child: const Text('Save'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Changes saved')), findsWidgets);
    },
  );
}
