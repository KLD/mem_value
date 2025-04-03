/// Exception thrown when a MemValue is invalid.
class MemValueException implements Exception {
  /// The exception message
  final String message;

  /// Creates a MemValueException instance
  const MemValueException(this.message);

  /// Returns a string representation of exception.
  @override
  String toString() {
    return 'MemValueException: $message';
  }
}
