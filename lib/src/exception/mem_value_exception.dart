class MemValueException implements Exception {
  final String message;

  const MemValueException(this.message);

  @override
  String toString() {
    return 'MemValueException: $message';
  }
}
