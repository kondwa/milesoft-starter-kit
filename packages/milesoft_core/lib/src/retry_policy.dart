import 'dart:async';

import 'result.dart';

/// A bounded retry policy for operations with typed outcomes.
final class RetryPolicy {
  RetryPolicy({
    this.attemptLimit = 3,
    this.initialDelay = const Duration(milliseconds: 100),
    this.delayCap = const Duration(seconds: 1),
    this._delay = _wait,
  }) {
    if (attemptLimit < 1) {
      throw ArgumentError.value(
        attemptLimit,
        'attemptLimit',
        'Must be positive',
      );
    }
    if (initialDelay.isNegative) {
      throw ArgumentError.value(
        initialDelay,
        'initialDelay',
        'Must be nonnegative',
      );
    }
    if (delayCap.isNegative) {
      throw ArgumentError.value(delayCap, 'delayCap', 'Must be nonnegative');
    }
  }

  /// Maximum total attempts, including the initial call.
  final int attemptLimit;

  /// The first retry delay before applying [delayCap].
  final Duration initialDelay;

  /// Upper bound on every retry delay.
  final Duration delayCap;

  final Future<void> Function(Duration) _delay;

  /// Runs [operation] and retries only explicitly safe transient failures.
  ///
  /// Returns the last outcome on exhaustion. Operation and delay exceptions
  /// propagate without conversion.
  Future<Result<T>> run<T>(
    FutureOr<Result<T>> Function() operation, {
    bool retrySafe = false,
  }) async {
    var backoff = initialDelay > delayCap ? delayCap : initialDelay;
    for (var attempt = 1; ; attempt++) {
      final result = await operation();
      if (!retrySafe ||
          attempt == attemptLimit ||
          result is! Failed<T> ||
          result.failure.code != FailureCode.transient) {
        return result;
      }

      await _delay(backoff);
      backoff = backoff.inMicroseconds > delayCap.inMicroseconds ~/ 2
          ? delayCap
          : backoff * 2;
    }
  }

  static Future<void> _wait(Duration duration) =>
      Future<void>.delayed(duration);
}
