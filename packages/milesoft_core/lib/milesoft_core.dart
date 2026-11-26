/// Removes leading and trailing whitespace from a display label.
///
/// Preserves case and internal whitespace. Empty and whitespace-only labels
/// return an empty string.
String normalizeLabel(String value) => value.trim();
