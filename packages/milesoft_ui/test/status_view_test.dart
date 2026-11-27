import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

Widget _app(Widget child) => MaterialApp(
  theme: MileSoftTheme.build(),
  home: Scaffold(body: child),
);

void main() {
  testWidgets('all four states expose caller text and distinct visual cues', (
    tester,
  ) async {
    for (final (status, title, icon) in [
      (MileSoftStatus.loading, 'Loading records', null),
      (MileSoftStatus.empty, 'No records', Icons.inbox_outlined),
      (MileSoftStatus.success, 'Records saved', Icons.check_circle_outline),
      (MileSoftStatus.error, 'Could not load records', Icons.error_outline),
    ]) {
      await tester.pumpWidget(
        _app(
          MileSoftStatusView(
            status: status,
            title: title,
            message: 'Details about the status',
          ),
        ),
      );
      expect(find.bySemanticsLabel(RegExp(title)), findsWidgets);
      expect(find.text('Details about the status'), findsOneWidget);
      if (icon == null) {
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      } else {
        expect(find.byIcon(icon), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      }
      expect(find.byType(MileSoftButton), findsNothing);
    }
  });

  testWidgets('the recoverable error action invokes retry', (tester) async {
    var retries = 0;
    await tester.pumpWidget(
      _app(
        MileSoftStatusView(
          status: MileSoftStatus.error,
          title: 'Could not load records',
          action: (
            label: 'Try again',
            onPressed: () {
              retries++;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Try again'));
    await tester.pump();
    expect(retries, 1);
  });

  testWidgets(
    'long scaled text fits at narrow width and keeps the action reachable',
    (tester) async {
      tester.view.physicalSize = const Size(320, 240);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var calls = 0;

      await tester.pumpWidget(
        _app(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: MileSoftStatusView(
              status: MileSoftStatus.empty,
              title: 'No records match your current settings',
              message: List.filled(
                12,
                'You can change the selected filters to show more records.',
              ).join(' '),
              action: (
                label: 'Change filters',
                onPressed: () {
                  calls++;
                },
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Change filters'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Change filters'));
      expect(calls, 1);
      expect(tester.takeException(), isNull);
    },
  );
}
