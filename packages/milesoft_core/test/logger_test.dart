import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

import 'support/core_fakes.dart';

void main() {
  test('sends structured severity and event names to the injected sink', () {
    final sink = RecordingLogSink();
    final logger = Logger(sink: sink.record);

    for (final level in LogLevel.values) {
      logger.log(level, 'operation.completed');
    }

    expect(sink.entries.map((entry) => entry.level), LogLevel.values);
    expect(
      sink.entries.map((entry) => entry.event),
      everyElement('operation.completed'),
    );
    expect(sink.entries.map((entry) => entry.fields), everyElement(isEmpty));
  });

  test(
    'retains allowlisted metrics and excludes free text and private fields',
    () {
      final sink = RecordingLogSink();
      final keys = {'attempt', 'completed', 'elapsed_ms'};
      final logger = Logger(sink: sink.record, allowedFieldKeys: keys);
      keys.add('account_id');

      final fields = <String, Object?>{
        'attempt': 2,
        'completed': true,
        'elapsed_ms': 'token-fixture',
        'email': 'private@example.invalid',
        'account_id': 1234,
      };
      logger.log(LogLevel.warning, 'operation.retry', fields: fields);
      fields['attempt'] = 3;

      final captured = sink.entries.single.fields;
      expect(captured, {'attempt': 2, 'completed': true});
      expect(() => captured.clear(), throwsUnsupportedError);
    },
  );
}
