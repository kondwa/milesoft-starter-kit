/// The outcome of an operation that can report an expected failure.
///
/// Use an exhaustive switch over [Success] and [Failed] to handle both
/// outcomes. Convert only recognised exceptions at the boundary that knows
/// what they mean. Let unexpected exceptions propagate with their stacks.
sealed class Result<T> {
  const Result();

  /// Transforms a success or carries the same failure forward.
  ///
  /// Exceptions thrown by [transform] propagate to the caller.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success<T>(:final value) => Success<R>(transform(value)),
    Failed<T>(:final failure) => Failed<R>(failure),
  };
}

/// A successful outcome. [value] may be null when [T] permits it.
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

/// An expected failure, independent of the successful value type.
final class Failed<T> extends Result<T> {
  const Failed(this.failure);

  final Failure failure;
}

/// The supported categories of expected failure.
enum FailureCode {
  validation('validation'),
  authorization('authorization'),
  transient('transient');

  const FailureCode(this.code);

  /// The stable string identifier for this category.
  final String code;
}

/// An expected failure that callers can map to safe, localised feedback.
///
/// Keep raw exceptions, stacks and diagnostic payloads at the reporting
/// boundary. Use stable field and issue identifiers rather than input values.
final class Failure {
  Failure(this.code, {Iterable<ValidationIssue> fieldIssues = const []})
    : fieldIssues = List.unmodifiable(fieldIssues);

  final FailureCode code;

  /// An immutable snapshot of the associated field issues, if any.
  final List<ValidationIssue> fieldIssues;
}

/// A validation issue identified by a field key and an issue code.
///
/// Choose stable identifiers and resolve display text in the caller. Keep
/// submitted values and private diagnostic details out of these identifiers.
final class ValidationIssue {
  const ValidationIssue({required this.fieldKey, required this.code});

  final String fieldKey;
  final String code;
}
