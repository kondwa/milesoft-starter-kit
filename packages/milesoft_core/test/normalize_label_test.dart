import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

void main() {
  group('normalizeLabel', () {
    test('trims whitespace from both ends', () {
      expect(
        normalizeLabel('  MileSoft Starter Kit  '),
        'MileSoft Starter Kit',
      );
    });

    test('preserves internal whitespace and case', () {
      expect(normalizeLabel('  Two  words  '), 'Two  words');
    });

    test('returns an empty string for empty input', () {
      expect(normalizeLabel(''), isEmpty);
    });

    test('returns an empty string for whitespace-only input', () {
      expect(normalizeLabel(' \t\n '), isEmpty);
    });
  });
}
