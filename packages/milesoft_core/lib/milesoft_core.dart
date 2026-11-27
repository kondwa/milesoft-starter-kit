export 'src/app_config.dart';
export 'src/clock.dart';
export 'src/id_generator.dart';
export 'src/logger.dart';
export 'src/pagination.dart';
export 'src/result.dart';
export 'src/retry_policy.dart';
export 'src/use_case.dart';
export 'src/validation.dart';

/// Removes leading and trailing whitespace from a display label.
///
/// Preserves case and internal whitespace. Empty and whitespace-only labels
/// return an empty string.
String normalizeLabel(String value) => value.trim();
