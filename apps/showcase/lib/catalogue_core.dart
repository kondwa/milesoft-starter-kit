import 'package:material_ui/material_ui.dart' hide Page;
import 'package:milesoft_core/milesoft_core.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

import 'l10n/app_localizations.dart';

class CoreCatalogue extends StatefulWidget {
  const CoreCatalogue({super.key});

  @override
  State<CoreCatalogue> createState() => _CoreCatalogueState();
}

class _CoreCatalogueState extends State<CoreCatalogue> {
  late final Future<int?> _attempts = _runRetry();

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    final outcomes = _demonstrateCore(copy);
    final date = MaterialLocalizations.of(context)
        .formatMediumDate(outcomes.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MileSoftTokens.spacing.medium,
      children: [
        _Example(
          title: copy.coreResult,
          children: [
            if (outcomes.normalised case Success<String>(:final value))
              Text(copy.coreUseCaseValue(value)),
            if (outcomes.invalid case Failed<String>())
              Text(copy.coreValidationIssue),
          ],
        ),
        _Example(
          title: copy.corePage,
          children: [
            Text(
              copy.corePageValue(
                outcomes.page.items.single,
                outcomes.page.nextOffset!,
              ),
            ),
          ],
        ),
        _Example(
          title: copy.coreUtilities,
          children: [
            Text(
              copy.coreUtilitiesValue(
                date,
                outcomes.identifier,
                outcomes.attempt,
              ),
            ),
          ],
        ),
        _Example(
          title: copy.coreRetry,
          children: [
            FutureBuilder<int?>(
              future: _attempts,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Text(copy.loadingTitle);
                }
                return Text(switch (snapshot.data) {
                  final attempts? => copy.coreRetryResult(attempts),
                  null => copy.coreRetryUnavailable,
                });
              },
            ),
          ],
        ),
        _Example(
          title: copy.coreConfiguration,
          children: [
            Text(switch (outcomes.config) {
              Success<AppConfig>(:final value)
                  when value.featureFlags.isEnabled('preview') =>
                copy.coreConfigResult(value.environment.name),
              _ => copy.coreConfigUnavailable,
            }),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => MileSoftCard(
    child: Padding(
      padding: EdgeInsets.all(MileSoftTokens.spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MileSoftTokens.spacing.small,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ...children,
        ],
      ),
    ),
  );
}

typedef _CoreOutcomes = ({
  Result<String> normalised,
  Result<String> invalid,
  Page<String> page,
  DateTime date,
  String identifier,
  int attempt,
  Result<AppConfig> config,
});

_CoreOutcomes _demonstrateCore(AppLocalizations copy) {
  final Validator<String> validate = _validateLabel;
  Result<String> normalise(String input) {
    final issues = validate(input);
    return issues.isEmpty
        ? Success(input)
        : Failed(Failure(FailureCode.validation, fieldIssues: issues));
  }

  final UseCase<String, String> useCase = normalise;
  final normalised = (useCase('  ${copy.showcaseLabel}  ') as Result<String>)
      .map(normalizeLabel);
  final invalid = useCase(' ') as Result<String>;

  final request = PaginationParams.create(offset: 0, size: 1);
  final params = (request as Success<PaginationParams>).value;
  final filtered =
      [
            (included: true, label: copy.emailOption),
            (included: false, label: copy.weeklyOption),
            (included: true, label: copy.smsOption),
          ]
          .where((record) => record.included)
          .map((record) => record.label)
          .toList()
        ..sort();
  final page = Page(
    items: filtered.skip(params.offset).take(params.size),
    nextOffset: params.offset + params.size,
  );

  const Clock clock = _FixtureClock();
  const IdGenerator ids = _FixtureIdGenerator();
  final logs = <LogEntry>[];
  final logger = Logger(sink: logs.add, allowedFieldKeys: {'attempt'});
  logger.log(LogLevel.info, 'catalogue.fixture', fields: {'attempt': 1});

  final config = AppConfig.load(
    environment: Environment.development,
    defaults: {
      'name': copy.showcaseLabel,
      'identifier': 'com.milesoft.showcase',
      'language': 'en',
      'region': 'MW',
      'currency': 'MWK',
      'legalUrl': 'https://example.invalid/legal',
      'supportUrl': 'https://example.invalid/support',
    },
    environments: const {
      Environment.development: {
        'featureFlags': {'preview': true},
      },
    },
    supportedLocales: const (
      languages: {'en'},
      regions: {'MW'},
      currencies: {'MWK'},
    ),
  );

  return (
    normalised: normalised,
    invalid: invalid,
    page: page,
    date: clock.nowUtc(),
    identifier: ids.generate(),
    attempt: logs.single.fields['attempt'] as int,
    config: config,
  );
}

List<ValidationIssue> _validateLabel(String value) => [
  if (value.trim().isEmpty)
    const ValidationIssue(fieldKey: 'label', code: 'required'),
];

Future<int?> _runRetry() async {
  var attempts = 0;
  final policy = RetryPolicy(delay: (_) async {});
  final result = await policy.run<int>(() {
    attempts++;
    return attempts == 1
        ? Failed(Failure(FailureCode.transient))
        : Success(attempts);
  }, retrySafe: true);
  return switch (result) {
    Success<int>(:final value) => value,
    Failed<int>() => null,
  };
}

final class _FixtureClock implements Clock {
  const _FixtureClock();

  @override
  DateTime nowUtc() => DateTime.utc(2026, 11, 26);
}

final class _FixtureIdGenerator implements IdGenerator {
  const _FixtureIdGenerator();

  @override
  String generate() => 'demo-001';
}
