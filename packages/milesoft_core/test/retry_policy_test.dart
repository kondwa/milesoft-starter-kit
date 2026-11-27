import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

void main() {
  late List<Duration> delays;
  late RetryPolicy policy;

  setUp(() {
    delays = [];
    policy = RetryPolicy(delay: (duration) async => delays.add(duration));
  });

  test('returns immediate success with no delay', () async {
    const success = Success(42);
    expect(await policy.run(() => success, retrySafe: true), same(success));
    expect(delays, isEmpty);
  });

  test('retries a safe transient failure and stops on success', () async {
    var calls = 0;
    final failure = Failure(FailureCode.transient);

    final result = await policy.run<int>(() async {
      calls++;
      return calls == 1 ? Failed(failure) : const Success(42);
    }, retrySafe: true);

    expect((result as Success<int>).value, 42);
    expect(calls, 2);
    expect(delays, [const Duration(milliseconds: 100)]);
  });

  test('default exhaustion returns the exact last failure', () async {
    final failures = List.generate(3, (_) => Failure(FailureCode.transient));
    var calls = 0;

    final result = await policy.run<int>(
      () => Failed(failures[calls++]),
      retrySafe: true,
    );

    expect((result as Failed<int>).failure, same(failures.last));
    expect(calls, 3);
    expect(delays.map((delay) => delay.inMilliseconds), [100, 200]);
  });

  test('configurable backoff doubles and stays capped', () async {
    final bounded = RetryPolicy(
      attemptLimit: 6,
      initialDelay: const Duration(milliseconds: 300),
      delay: (duration) async => delays.add(duration),
    );
    final failure = Failure(FailureCode.transient);

    await bounded.run<int>(() => Failed(failure), retrySafe: true);

    expect(delays.map((delay) => delay.inMilliseconds), [
      300,
      600,
      1000,
      1000,
      1000,
    ]);
  });

  test('unsafe operations and terminal failures run exactly once', () async {
    for (final code in FailureCode.values) {
      final failure = Failure(code);
      var calls = 0;
      final result = await policy.run<int>(() {
        calls++;
        return Failed(failure);
      }, retrySafe: code != FailureCode.transient);
      expect((result as Failed<int>).failure, same(failure));
      expect(calls, 1);
    }
    expect(delays, isEmpty);
  });

  test(
    'unexpected exceptions propagate immediately with their stack',
    () async {
      final error = StateError('unexpected');
      final originalStack = StackTrace.fromString('original operation stack');
      var calls = 0;

      try {
        await policy.run<int>(() {
          calls++;
          Error.throwWithStackTrace(error, originalStack);
        }, retrySafe: true);
        fail('Expected the operation error');
      } on StateError catch (caught, stack) {
        expect(caught, same(error));
        expect(stack.toString(), originalStack.toString());
      }
      expect(calls, 1);
      expect(delays, isEmpty);
    },
  );

  test('rejects invalid policy settings', () {
    expect(() => RetryPolicy(attemptLimit: 0), throwsArgumentError);
    expect(
      () => RetryPolicy(initialDelay: const Duration(microseconds: -1)),
      throwsArgumentError,
    );
    expect(
      () => RetryPolicy(delayCap: const Duration(microseconds: -1)),
      throwsArgumentError,
    );
  });
}
