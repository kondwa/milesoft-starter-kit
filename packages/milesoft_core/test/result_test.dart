import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

void main() {
  test('success and failure are distinct even for nullable values', () {
    const Result<String?> result = Success<String?>(null);

    expect(result, isA<Success<String?>>());
    expect((result as Success<String?>).value, isNull);
    expect(const Success<int>(42).value, 42);
  });

  test('map transforms a success and permits nullable output', () {
    const Result<int> result = Success(42);

    expect((result.map((value) => '$value') as Success<String>).value, '42');
    expect(
      (result.map<String?>((_) => null) as Success<String?>).value,
      isNull,
    );
  });

  test('map preserves the failure and never invokes the transform', () {
    final failure = Failure(FailureCode.authorization);
    final Result<int> result = Failed(failure);

    final mapped = result.map<String>((_) => throw StateError('called'));

    expect((mapped as Failed<String>).failure, same(failure));
  });

  test('uses stable codes for expected failures', () {
    expect(FailureCode.validation.code, 'validation');
    expect(FailureCode.authorization.code, 'authorization');
    expect(FailureCode.transient.code, 'transient');
  });

  test('field issues are immutable and support multiple issues per field', () {
    final issues = [
      const ValidationIssue(fieldKey: 'email', code: 'required'),
      const ValidationIssue(fieldKey: 'email', code: 'format'),
    ];
    final failure = Failure(FailureCode.validation, fieldIssues: issues);
    issues.clear();

    expect(failure.fieldIssues.map((issue) => issue.fieldKey), [
      'email',
      'email',
    ]);
    expect(failure.fieldIssues.map((issue) => issue.code), [
      'required',
      'format',
    ]);
    expect(() => failure.fieldIssues.clear(), throwsUnsupportedError);
    expect(Failure(FailureCode.transient).fieldIssues, isEmpty);
  });

  test('default diagnostics omit caller-supplied issue values', () {
    const privateFixture = 'private-fixture';
    final issue = ValidationIssue(fieldKey: 'email', code: privateFixture);
    final result = Failed<int>(
      Failure(FailureCode.validation, fieldIssues: [issue]),
    );

    expect(issue.toString(), isNot(contains(privateFixture)));
    expect(result.failure.toString(), isNot(contains(privateFixture)));
    expect(result.toString(), isNot(contains(privateFixture)));
  });

  test('unexpected mapper exceptions propagate with their original stack', () {
    final error = StateError('unexpected');
    final stack = StackTrace.fromString('mapper test stack');
    const Result<int> result = Success(42);

    expect(
      () => result.map<int>((_) => Error.throwWithStackTrace(error, stack)),
      throwsA(same(error)),
    );
    try {
      result.map<int>((_) => Error.throwWithStackTrace(error, stack));
      fail('Expected the mapper exception');
    } on StateError catch (caught, trace) {
      expect(caught, same(error));
      expect(trace.toString(), stack.toString());
    }
  });
}
