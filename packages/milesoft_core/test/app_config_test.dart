import 'package:milesoft_core/milesoft_core.dart';
import 'package:test/test.dart';

const _supported = (
  languages: {'en', 'ny'},
  regions: {'MW', 'GB'},
  currencies: {'MWK', 'GBP'},
);

Map<String, Object?> _defaults() => {
  'name': 'Starter Kit',
  'identifier': 'com.milesoft.starter_kit',
  'language': 'en',
  'region': 'MW',
  'currency': 'MWK',
  'legalUrl': 'https://example.invalid/legal',
  'supportUrl': 'https://example.invalid/support',
  'brandingReferences': {'logo': 'assets/logo.png'},
  'featureFlags': {'catalogue': true, 'preview': false},
};

Result<AppConfig> _load(
  Map<String, Object?> defaults, {
  Environment environment = Environment.production,
  Map<Environment, Map<String, Object?>> environments = const {},
  Map<String, Object?> testOverrides = const {},
}) => AppConfig.load(
  environment: environment,
  defaults: defaults,
  environments: environments,
  supportedLocales: _supported,
  testOverrides: testOverrides,
);

List<String> _issueFields(Result<AppConfig> outcome) {
  final failure = (outcome as Failed<AppConfig>).failure;
  expect(failure.code, FailureCode.validation);
  return failure.fieldIssues.map((issue) => issue.fieldKey).toList();
}

void main() {
  for (final environment in Environment.values) {
    test('$environment validates winning values and isolates flags', () {
      final settings = {
        environment: {
          'name': 'Environment product',
          'featureFlags': {'preview': true},
        },
      };
      final config = (_load(
        _defaults(),
        environment: environment,
        environments: settings,
        testOverrides: {
          'featureFlags': {'preview': false},
        },
      ) as Success<AppConfig>).value;
      expect(config.name, 'Environment product');
      expect(config.featureFlags.isEnabled('preview'), isFalse);
      expect(config.featureFlags.isEnabled('catalogue'), isTrue);
      expect(
        _issueFields(
          _load(
            _defaults(),
            environment: environment,
            environments: settings,
            testOverrides: {'name': ' '},
          ),
        ),
        ['name'],
      );
    });
  }

  test('loads only the requested environment and inherits omitted fields', () {
    final environments = {
      Environment.development: {'name': 'Development', 'language': 'ny'},
      Environment.staging: {'name': 'Staging', 'currency': 'GBP'},
      Environment.production: {'name': 'Production', 'region': 'GB'},
    };

    for (final environment in Environment.values) {
      final config = (_load(
        _defaults(),
        environment: environment,
        environments: environments,
      ) as Success<AppConfig>).value;

      expect(config.environment, environment);
      expect(config.name, environments[environment]!['name']);
      expect(config.identifier, 'com.milesoft.starter_kit');
      expect(
        config.localeDefaults.language,
        environment == Environment.development ? 'ny' : 'en',
      );
      expect(
        config.localeDefaults.region,
        environment == Environment.production ? 'GB' : 'MW',
      );
      expect(
        config.localeDefaults.currency,
        environment == Environment.staging ? 'GBP' : 'MWK',
      );
      expect(config.urls.legal, Uri.parse('https://example.invalid/legal'));
    }
  });

  test('test overrides win and feature flags merge by key', () {
    final config = (_load(
      _defaults(),
      environments: {
        Environment.production: {
          'name': 'Production',
          'featureFlags': {'preview': true, 'archived': true},
        },
      },
      testOverrides: {
        'name': 'Test',
        'featureFlags': {'preview': false},
      },
    ) as Success<AppConfig>).value;

    expect(config.name, 'Test');
    expect(config.featureFlags.isEnabled('catalogue'), isTrue);
    expect(config.featureFlags.isEnabled('archived'), isTrue);
    expect(config.featureFlags.isEnabled('preview'), isFalse);
    expect(config.featureFlags.isEnabled('missing'), isFalse);
  });

  test('reports all missing required settings and permits absent branding and flags', () {
    expect(
      _issueFields(_load({})),
      unorderedEquals([
        'name',
        'identifier',
        'language',
        'region',
        'currency',
        'legalUrl',
        'supportUrl',
      ]),
    );

    final values = _defaults()
      ..remove('brandingReferences')
      ..remove('featureFlags');
    final config = (_load(values) as Success<AppConfig>).value;
    expect(config.brandingReferences, isEmpty);
    expect(config.featureFlags.isEnabled('catalogue'), isFalse);
  });

  test('rejects invalid winning values and aggregates safe issues', () {
    final result = _load(
      _defaults(),
      testOverrides: {
        'name': ' ',
        'identifier': 'com.2bad',
        'language': 'fr',
        'region': 'US',
        'currency': 'USD',
        'legalUrl': '/relative',
        'supportUrl': 'https://user:password@example.invalid/',
        'brandingReferences': {'logo': ' '},
        'featureFlags': {'preview': 'true'},
      },
    );

    expect(
      _issueFields(result),
      unorderedEquals([
        'name',
        'identifier',
        'language',
        'region',
        'currency',
        'legalUrl',
        'supportUrl',
        'brandingReferences.logo',
        'featureFlags.preview',
      ]),
    );
    final failure = (result as Failed<AppConfig>).failure;
    expect(
      failure.fieldIssues.map((issue) => issue.code),
      isNot(contains('password')),
    );
  });

  test('a valid higher layer can replace bad defaults', () {
    final result = _load(
      _defaults()..['featureFlags'] = {'preview': 'true'},
      testOverrides: {
        'featureFlags': {'preview': true},
      },
    );
    expect(
      (result as Success<AppConfig>).value.featureFlags.isEnabled('preview'),
      isTrue,
    );
  });

  test('validates URL hosts, credentials and schemes', () {
    for (final url in [
      'https:///support',
      'https://@example.invalid/',
      'ftp://example.invalid/',
    ]) {
      expect(_issueFields(_load(_defaults()..['supportUrl'] = url)), [
        'supportUrl',
      ]);
    }
    final result = _load(
      _defaults()..['supportUrl'] = 'http://example.invalid/',
    );
    expect((result as Success<AppConfig>).value.urls.support.scheme, 'http');
  });

  test('keeps immutable snapshots of branding and flags', () {
    final branding = {'logo': 'assets/logo.png'};
    final flags = {'catalogue': true};
    final values = _defaults()
      ..['brandingReferences'] = branding
      ..['featureFlags'] = flags;
    final config = (_load(values) as Success<AppConfig>).value;
    branding.clear();
    flags.clear();

    expect(config.brandingReferences, {'logo': 'assets/logo.png'});
    expect(() => config.brandingReferences.clear(), throwsUnsupportedError);
    expect(config.featureFlags.isEnabled('catalogue'), isTrue);
  });
}
