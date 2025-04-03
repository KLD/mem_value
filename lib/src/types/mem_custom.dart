import '../core/mem_value.dart';

/// A custom implementation of [MemValue]
class MemCustom<T> extends MemValue<T> {
  /// Converts a custom value to a string.
  final String Function(T v) stringifyValue;

  /// Converts a string to custom value.
  final T Function(String v) parseValue;

  /// Creates a [MemCustom] instance.
  MemCustom(super.tag,
      {required this.parseValue,
      required this.stringifyValue,
      required super.initValue,
      super.ignoreReset});

  @override
  T parse(String value) => parseValue(value);

  @override
  String stringify(T value) => stringifyValue(value);
}
