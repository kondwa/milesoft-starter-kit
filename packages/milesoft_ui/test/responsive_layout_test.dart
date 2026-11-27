import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

void main() {
  testWidgets('uses available width and switches at the caller breakpoint', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    Future<void> show(double width) => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: width,
              child: const MileSoftResponsiveLayout(
                wideMinWidth: 720,
                primary: Text('Primary'),
                secondary: Text('Secondary'),
              ),
            ),
          ),
        ),
      ),
    );

    await show(719);
    expect(
      tester.getTopLeft(find.text('Primary')).dx,
      tester.getTopLeft(find.text('Secondary')).dx,
    );
    expect(
      tester.getTopLeft(find.text('Secondary')).dy,
      greaterThan(tester.getTopLeft(find.text('Primary')).dy),
    );

    await show(720);
    final paneWidth = (720 - MileSoftTokens.spacing.medium) / 2;
    expect(tester.getSize(find.text('Primary')).width, paneWidth);
    expect(tester.getSize(find.text('Secondary')).width, paneWidth);
    expect(
      tester.getTopLeft(find.text('Secondary')).dx,
      greaterThan(tester.getTopLeft(find.text('Primary')).dx),
    );
    expect(
      tester.getTopLeft(find.text('Primary')).dy,
      tester.getTopLeft(find.text('Secondary')).dy,
    );
  });

  testWidgets('long content can scroll at both widths and text scales', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final details = List.filled(
      16,
      'This is a long display label for the layout test.',
    ).join(' ');

    for (final width in [320.0, 1280.0]) {
      for (final scale in [1.0, 2.0]) {
        tester.view.physicalSize = Size(width, 360);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(scale)),
                  child: SingleChildScrollView(
                    child: MileSoftResponsiveLayout(
                      wideMinWidth: 720,
                      primary: Text(details),
                      secondary: const Text('Next section'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        await tester.ensureVisible(find.text('Next section'));
        await tester.pumpAndSettle();
        expect(find.text('Next section').hitTestable(), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets(
    'keeps keyboard order across a resize and mirrors wide RTL layout',
    (tester) async {
      final primaryFocus = FocusNode();
      final secondaryFocus = FocusNode();
      addTearDown(primaryFocus.dispose);
      addTearDown(secondaryFocus.dispose);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      tester.view.physicalSize = const Size(320, 500);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: MileSoftResponsiveLayout(
                wideMinWidth: 720,
                primary: TextButton(
                  focusNode: primaryFocus,
                  onPressed: () {},
                  child: const Text('First'),
                ),
                secondary: TextButton(
                  focusNode: secondaryFocus,
                  onPressed: () {},
                  child: const Text('Second'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(primaryFocus.hasFocus, isTrue);

      tester.view.physicalSize = const Size(1280, 500);
      await tester.pumpAndSettle();
      expect(primaryFocus.hasFocus, isTrue);
      expect(
        tester.getCenter(find.text('First')).dx,
        greaterThan(tester.getCenter(find.text('Second')).dx),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(secondaryFocus.hasFocus, isTrue);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('uses compact layout when width is unbounded', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              MileSoftResponsiveLayout(
                wideMinWidth: 720,
                primary: Text('Primary'),
                secondary: Text('Secondary'),
              ),
            ],
          ),
        ),
      ),
    );
    expect(
      tester.getTopLeft(find.text('Secondary')).dy,
      greaterThan(tester.getTopLeft(find.text('Primary')).dy),
    );
    expect(tester.takeException(), isNull);
  });
}
