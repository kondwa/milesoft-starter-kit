import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

void main() {
  test('accepts zero-based offsets and both size boundaries', () {
    final first = PaginationParams.create(
      offset: 0,
      size: 1,
    ) as Success<PaginationParams>;
    final later = PaginationParams.create(
      offset: 7,
      size: 100,
    ) as Success<PaginationParams>;

    expect((first.value.offset, first.value.size), (0, 1));
    expect((later.value.offset, later.value.size), (7, 100));
  });

  test('reports every invalid field as a typed validation failure', () {
    for (final (offset, size, fields) in [
      (-1, 1, ['offset']),
      (0, 0, ['size']),
      (0, 101, ['size']),
      (-1, 101, ['offset', 'size']),
    ]) {
      final result = PaginationParams.create(offset: offset, size: size);
      final failure = (result as Failed<PaginationParams>).failure;

      expect(failure.code, FailureCode.validation);
      expect(failure.fieldIssues.map((issue) => issue.fieldKey), fields);
    }
  });

  test(
    'traverses caller-filtered and sorted data using source continuation',
    () {
      final filtered = [
        'pear',
        'apple',
        'plum',
        'apricot',
      ].where((item) => item.startsWith('a')).toList()..sort();

      Page<String> read(int offset) {
        final result = PaginationParams.create(offset: offset, size: 1);
        final params = (result as Success<PaginationParams>).value;
        return Page(
          items: filtered.skip(params.offset).take(params.size),
          nextOffset: params.offset == 0 ? 1 : null,
        );
      }

      final first = read(0);
      expect(first.items, ['apple']);
      final finalPage = read(first.nextOffset!);
      expect(finalPage.items, ['apricot']);
      expect(finalPage.nextOffset, isNull);
    },
  );

  test('keeps source continuation even when a nonempty page is short', () {
    final page = Page(items: ['apple'], nextOffset: 8);
    expect(page.nextOffset, 8);
  });

  test('empty pages end traversal even when the source supplies an offset', () {
    final page = Page<String>(items: [], nextOffset: 8);
    expect(page.items, isEmpty);
    expect(page.nextOffset, isNull);
  });

  test('page items are an immutable snapshot', () {
    final items = ['apple'];
    final page = Page(items: items);
    items.clear();

    expect(page.items, ['apple']);
    expect(() => page.items.clear(), throwsUnsupportedError);
  });
}
