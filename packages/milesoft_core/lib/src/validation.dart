import 'result.dart';

/// Checks [input] synchronously and returns any structured field issues.
///
/// An empty list means the input is valid. Return stable field and issue codes
/// so the caller can choose localised feedback without exposing input values.
typedef Validator<T> = List<ValidationIssue> Function(T input);
