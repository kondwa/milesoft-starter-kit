/// An injectable source of identifiers.
///
/// The implementation defines the uniqueness scope and must meet the caller's
/// domain requirements. This contract provides no cryptographic guarantee.
abstract interface class IdGenerator {
  /// Returns an identifier within the implementation's documented scope.
  String generate();
}
