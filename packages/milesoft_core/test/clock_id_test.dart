import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

import 'support/core_fakes.dart';

void main() {
  test('the system clock returns UTC within the observed time window', () {
    final before = DateTime.now().toUtc();
    final instant = const SystemClock().nowUtc();
    final after = DateTime.now().toUtc();

    expect(instant.isUtc, isTrue);
    expect(instant.isBefore(before), isFalse);
    expect(instant.isAfter(after), isFalse);
  });

  test('an injected clock preserves the instant and always returns UTC', () {
    final local = DateTime(2026, 11, 26, 8);
    final Clock clock = FixedClock(local);

    expect(clock.nowUtc().isUtc, isTrue);
    expect(clock.nowUtc().isAtSameMomentAs(local), isTrue);
    expect(clock.nowUtc(), clock.nowUtc());
  });

  test('injected ID sources produce a repeatable sequence in each fixture', () {
    final IdGenerator first = SequentialIdGenerator();
    final IdGenerator second = SequentialIdGenerator();

    expect([first.generate(), first.generate()], ['test-1', 'test-2']);
    expect([second.generate(), second.generate()], ['test-1', 'test-2']);
  });
}
