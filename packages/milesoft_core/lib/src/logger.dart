/// Severity of a structured log entry, from least to most severe.
enum LogLevel { debug, info, warning, error }

/// A structured event ready to pass to a logging adapter.
final class LogEntry {
  const LogEntry._(this.level, this.event, this.fields);

  final LogLevel level;

  /// A fixed event identifier chosen by the caller.
  final String event;

  /// An unmodifiable snapshot of allowed numeric and boolean metadata.
  final Map<String, Object> fields;
}

/// Sends structured events to an injected sink.
///
/// Configure [allowedFieldKeys] with reviewed, non-sensitive metadata keys.
/// The allowlist is empty by default. Keep event names static and keep secrets,
/// personal data and identifiers out of metadata, even when encoded as numbers.
final class Logger {
  Logger({required this._sink, Iterable<String> allowedFieldKeys = const []})
    : _allowedFieldKeys = Set.unmodifiable(allowedFieldKeys);

  final void Function(LogEntry entry) _sink;
  final Set<String> _allowedFieldKeys;

  /// Emits an event, retaining only allowlisted numeric and boolean fields.
  void log(
    LogLevel level,
    String event, {
    Map<String, Object?> fields = const {},
  }) {
    final metadata = <String, Object>{};
    for (final entry in fields.entries) {
      final value = entry.value;
      if (_allowedFieldKeys.contains(entry.key) &&
          (value is num || value is bool)) {
        metadata[entry.key] = value!;
      }
    }

    _sink(LogEntry._(level, event, Map.unmodifiable(metadata)));
  }
}
