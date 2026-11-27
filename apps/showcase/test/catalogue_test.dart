import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:showcase/main.dart';

Future<void> _openCatalogue(WidgetTester tester) async {
  await tester.pumpWidget(const ShowcaseApp());
  await tester.tap(find.text('Browse catalogue'));
  await tester.pumpAndSettle();
}

Future<void> _section(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  for (final width in [320.0, 1280.0]) {
    for (final scale in [1.0, 2.0]) {
      for (final brightness in Brightness.values) {
        testWidgets(
          'catalogue layout and targets at $width px, $scale×, $brightness',
          (tester) async {
            final dispatcher = tester.platformDispatcher;
            tester.view.devicePixelRatio = 1;
            tester.view.physicalSize = Size(width, 640);
            dispatcher.textScaleFactorTestValue = scale;
            dispatcher.platformBrightnessTestValue = brightness;
            addTearDown(tester.view.resetDevicePixelRatio);
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(dispatcher.clearTextScaleFactorTestValue);
            addTearDown(dispatcher.clearPlatformBrightnessTestValue);

            await _openCatalogue(tester);
            await expectLater(
              tester,
              meetsGuideline(labeledTapTargetGuideline),
            );
            await expectLater(
              tester,
              meetsGuideline(androidTapTargetGuideline),
            );

            await _section(tester, 'Forms');
            final validate = find.text('Validate form');
            await tester.ensureVisible(validate);
            await tester.tap(validate);
            await tester.pumpAndSettle();
            final error = find.text('Enter a name.');
            await tester.ensureVisible(error);
            await tester.pumpAndSettle();
            expect(error.hitTestable(), findsOneWidget);
            final field = find.ancestor(
              of: error,
              matching: find.byType(TextFormField),
            );
            await tester.ensureVisible(field);
            await tester.pumpAndSettle();
            final editable = tester.widget<EditableText>(
              find.descendant(of: field, matching: find.byType(EditableText)),
            );
            final fieldRect = tester.getRect(field);
            expect(fieldRect.width, greaterThanOrEqualTo(48));
            // TextFormField also includes the validation message below the input.
            expect(
              tester.getTopLeft(error).dy - fieldRect.top,
              greaterThanOrEqualTo(48),
            );
            await tester.tapAt(Offset(fieldRect.center.dx, fieldRect.top + 4));
            await tester.pumpAndSettle();
            expect(editable.focusNode.hasFocus, isTrue);
            await expectLater(
              tester,
              meetsGuideline(labeledTapTargetGuideline),
            );
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }

  testWidgets('controls demonstrate dialog results and in-app feedback', (
    tester,
  ) async {
    await _openCatalogue(tester);
    await _section(tester, 'Buttons, cards and dialogs');
    expect(find.text('Disabled button'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.ensureVisible(find.text('Open confirmation'));
    await tester.tap(find.text('Open confirmation'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Confirm example'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Example confirmed'), findsOneWidget);
  });

  testWidgets(
    'keyboard opens the catalogue and each destination is discoverable',
    (tester) async {
      await tester.pumpWidget(const ShowcaseApp());
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(find.text('Component catalogue'), findsOneWidget);
      for (final label in [
        'Core and configuration',
        'Forms',
        'Buttons, cards and dialogs',
        'Status views',
        'Layout and branding',
      ]) {
        expect(
          find.bySemanticsLabel(RegExp(RegExp.escape(label))),
          findsWidgets,
        );
      }
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('MileSoft Starter Kit'), findsOneWidget);
    },
  );

  testWidgets('catalogue selects all three theme modes', (tester) async {
    await _openCatalogue(tester);
    for (final (label, mode) in [
      ('Dark', ThemeMode.dark),
      ('Light', ThemeMode.light),
      ('System', ThemeMode.system),
    ]) {
      await tester.tap(find.byType(DropdownButtonFormField<ThemeMode>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        mode,
      );
    }
  });

  testWidgets('forms demonstrate entry, switches and selection controls', (
    tester,
  ) async {
    await _openCatalogue(tester);
    await _section(tester, 'Forms');
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(RadioListTile<String>), findsNWidgets(2));
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });

  testWidgets('core fixtures run and the status catalogue can retry', (
    tester,
  ) async {
    await _openCatalogue(tester);
    await _section(tester, 'Core and configuration');
    expect(find.text('Retry completed in 2 attempts.'), findsOneWidget);
    expect(
      find.text('Environment: development. Preview is enabled.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();
    await _section(tester, 'Status views');
    expect(find.text('Records saved'), findsOneWidget);
    await tester.ensureVisible(find.text('Try again'));
    await tester.tap(find.text('Try again'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Retry requested'), findsOneWidget);
  });

  testWidgets(
    'attribution and adaptive panes remain reachable at 200 percent scale',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 568);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await _openCatalogue(tester);
      await _section(tester, 'Layout and branding');
      final attribution = find.text('Powered by MileSoft');
      await tester.ensureVisible(attribution);
      await tester.pumpAndSettle();
      expect(attribution.hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
