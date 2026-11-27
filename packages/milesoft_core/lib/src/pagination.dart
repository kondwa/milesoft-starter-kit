import 'result.dart';

/// A validated zero-based request into a filtered, consistently ordered source.
final class PaginationParams {
  const PaginationParams._({required this.offset, required this.size});

  /// The index of the first requested item in the filtered order.
  final int offset;

  /// The maximum number of requested items, from 1 through 100.
  final int size;

  /// Validates both fields and reports invalid values as field issues.
  static Result<PaginationParams> create({
    required int offset,
    required int size,
  }) {
    final issues = [
      if (offset < 0)
        const ValidationIssue(fieldKey: 'offset', code: 'out_of_range'),
      if (size < 1 || size > 100)
        const ValidationIssue(fieldKey: 'size', code: 'out_of_range'),
    ];
    if (issues.isNotEmpty) {
      return Failed(Failure(FailureCode.validation, fieldIssues: issues));
    }
    return Success(PaginationParams._(offset: offset, size: size));
  }
}

/// A snapshot of a page and its source-provided continuation.
final class Page<T> {
  /// Copies [items] in the order supplied by the caller.
  ///
  /// Supply [nextOffset] only when the source confirms more results. An empty
  /// page always ends traversal, even if the source supplies an offset.
  factory Page({required Iterable<T> items, int? nextOffset}) {
    final snapshot = List<T>.unmodifiable(items);
    return Page._(snapshot, snapshot.isEmpty ? null : nextOffset);
  }

  const Page._(this.items, this.nextOffset);

  /// An unmodifiable snapshot of the page items.
  final List<T> items;

  /// The next zero-based offset in the same filtered order, if any.
  final int? nextOffset;
}
