import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

void main() {
  test('a synchronous use case returns its typed result immediately', () {
    Result<String> describeInput(int input) => Success('$input');
    final UseCase<int, String> describe = describeInput;

    expect(
      describe(42),
      isA<Success<String>>().having((result) => result.value, 'value', '42'),
    );
  });

  test(
    'an asynchronous use case propagates the original typed failure',
    () async {
      final failure = Failure(FailureCode.authorization);
      Future<Result<int>> authorize(String _) async => Failed(failure);
      final UseCase<String, int> execute = authorize;

      final outcome = execute('request');
      expect(outcome, isA<Future<Result<int>>>());
      expect(
        await outcome,
        isA<Failed<int>>().having(
          (result) => result.failure,
          'failure',
          same(failure),
        ),
      );
    },
  );

  test('a validator returns issues synchronously and accepts valid input', () {
    List<ValidationIssue> checkFields(({String name, int age}) input) => [
      if (input.name.trim().isEmpty)
        const ValidationIssue(fieldKey: 'name', code: 'required'),
      if (input.age < 0)
        const ValidationIssue(fieldKey: 'age', code: 'out_of_range'),
    ];

    final Validator<({String name, int age})> validate = checkFields;
    expect(validate((name: 'Ada', age: 30)), isEmpty);
    final issues = validate((name: ' ', age: -1));
    expect(issues.map((issue) => (issue.fieldKey, issue.code)), [
      ('name', 'required'),
      ('age', 'out_of_range'),
    ]);
    final failure = Failure(FailureCode.validation, fieldIssues: issues);
    expect(failure.fieldIssues.first, same(issues.first));
  });
}
