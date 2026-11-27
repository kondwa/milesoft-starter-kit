/// An injectable source of wall-clock instants.
///
/// Implementations return UTC. Convert to local time at presentation boundaries.
abstract interface class Clock {
  /// Returns the current instant in UTC.
  DateTime nowUtc();
}

/// A clock backed by the host's wall clock.
final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime nowUtc() => DateTime.now().toUtc();
}
