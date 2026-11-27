import 'result.dart';

/// The runtime environments supported by product configuration.
enum Environment { development, staging, production }

/// Local switches for optional features.
///
/// An absent flag is disabled. Flags do not grant access or entitlements.
final class FeatureFlags {
  FeatureFlags._(Map<String, bool> values) : _values = Map.unmodifiable(values);

  final Map<String, bool> _values;

  bool isEnabled(String key) => _values[key] ?? false;
}

/// Validated, immutable public configuration for a product.
final class AppConfig {
  const AppConfig._({
    required this.environment,
    required this.name,
    required this.identifier,
    required this.brandingReferences,
    required this.localeDefaults,
    required this.urls,
    required this.featureFlags,
  });

  final Environment environment;
  final String name;
  final String identifier;
  final Map<String, String> brandingReferences;
  final ({String language, String region, String currency}) localeDefaults;
  final ({Uri legal, Uri support}) urls;
  final FeatureFlags featureFlags;

  /// Loads defaults, selected environment settings and explicit test overrides
  /// in that order. Use [testOverrides] only in test composition.
  ///
  /// Known settings are name, identifier, language, region, currency, legalUrl,
  /// supportUrl, brandingReferences and featureFlags. Supply URLs as strings.
  /// A supplied setting replaces the entire earlier setting, except that flag
  /// maps merge by key. Omitted settings inherit. Explicit null is invalid.
  ///
  /// Validate this result before starting dependent features. Supply public
  /// configuration and stable map keys only.
  static Result<AppConfig> load({
    required Environment environment,
    required Map<String, Object?> defaults,
    required ({
      Set<String> languages,
      Set<String> regions,
      Set<String> currencies,
    })
    supportedLocales,
    Map<Environment, Map<String, Object?>> environments = const {},
    Map<String, Object?> testOverrides = const {},
  }) {
    final settings = <String, Object?>{};
    for (final layer in [defaults, ?environments[environment], testOverrides]) {
      final previousFlags = settings['featureFlags'];
      final newFlags = layer['featureFlags'];
      settings.addAll(layer);
      if (previousFlags is Map<String, Object?> &&
          newFlags is Map<String, Object?>) {
        settings['featureFlags'] = {...previousFlags, ...newFlags};
      }
    }

    final reader = _ConfigReader(settings);
    final name = reader.requiredValue('name', _nonblank);
    final identifier = reader.requiredValue('identifier', _applicationId);
    final language = reader.requiredValue(
      'language',
      (value) => _supported(value, supportedLocales.languages),
    );
    final region = reader.requiredValue(
      'region',
      (value) => _supported(value, supportedLocales.regions),
    );
    final currency = reader.requiredValue(
      'currency',
      (value) => _supported(value, supportedLocales.currencies),
    );
    final legalUrl = reader.requiredValue('legalUrl', _webUrl);
    final supportUrl = reader.requiredValue('supportUrl', _webUrl);
    final branding = reader.optionalMap('brandingReferences', _nonblank);
    final flags = reader.optionalMap(
      'featureFlags',
      (value) => value is bool ? value : null,
    );

    if (reader.issues.isNotEmpty) {
      return Failed(
        Failure(FailureCode.validation, fieldIssues: reader.issues),
      );
    }

    return Success(
      AppConfig._(
        environment: environment,
        name: name!,
        identifier: identifier!,
        brandingReferences: Map.unmodifiable(branding),
        localeDefaults: (
          language: language!,
          region: region!,
          currency: currency!,
        ),
        urls: (legal: legalUrl!, support: supportUrl!),
        featureFlags: FeatureFlags._(flags),
      ),
    );
  }
}

final class _ConfigReader {
  _ConfigReader(this.settings);

  final Map<String, Object?> settings;
  final issues = <ValidationIssue>[];

  T? requiredValue<T>(String key, T? Function(Object?) parse) {
    final value = parse(settings[key]);
    if (value == null) {
      issues.add(
        ValidationIssue(
          fieldKey: key,
          code: settings.containsKey(key) ? 'invalid' : 'required',
        ),
      );
    }
    return value;
  }

  Map<String, T> optionalMap<T>(String key, T? Function(Object?) parse) {
    if (!settings.containsKey(key)) return {};

    final raw = settings[key];
    if (raw is! Map<String, Object?>) {
      issues.add(ValidationIssue(fieldKey: key, code: 'invalid'));
      return {};
    }

    final result = <String, T>{};
    for (final entry in raw.entries) {
      final value = parse(entry.value);
      if (value == null) {
        issues.add(
          ValidationIssue(fieldKey: '$key.${entry.key}', code: 'invalid'),
        );
      } else {
        result[entry.key] = value;
      }
    }
    return result;
  }
}

String? _nonblank(Object? value) =>
    value is String && value.trim().isNotEmpty ? value : null;

final _identifierPattern = RegExp(
  r'^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$',
);

String? _applicationId(Object? value) =>
    value is String && _identifierPattern.hasMatch(value) ? value : null;

String? _supported(Object? value, Set<String> allowed) =>
    value is String && value.trim().isNotEmpty && allowed.contains(value)
    ? value
    : null;

final _webAuthority = RegExp(r'^https?://([^/?#]+)', caseSensitive: false);

Uri? _webUrl(Object? value) {
  if (value is! String) return null;

  // Uri can normalise away an empty user-info section. Check the input first.
  final authority = _webAuthority.firstMatch(value)?.group(1);
  if (authority == null || authority.contains('@')) return null;

  final uri = Uri.tryParse(value);
  return uri != null && uri.host.isNotEmpty ? uri : null;
}
