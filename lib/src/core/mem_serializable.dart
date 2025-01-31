abstract mixin class MemSerializable<T> {
  /// Converts a value to a string.
  String stringify(T value);

  /// Converts a string to value.
  T parse(String value);
}
