import 'package:milesoft_core/milesoft_core.dart';

final class FixedClock implements Clock {
  FixedClock(DateTime instant) : _instant = instant.toUtc();

  final DateTime _instant;

  @override
  DateTime nowUtc() => _instant;
}

final class SequentialIdGenerator implements IdGenerator {
  int _next = 1;

  @override
  String generate() => 'test-${_next++}';
}

final class RecordingLogSink {
  final entries = <LogEntry>[];

  void record(LogEntry entry) => entries.add(entry);
}
