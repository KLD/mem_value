import '../core/mem_value.dart';

class MemCustom<T> extends MemValue<T> {
  final String Function(T v) stringifyValue;
  final T Function(String v) parseValue;

  MemCustom(super.tag,
      {required this.parseValue,
      required this.stringifyValue,
      required super.initValue,
      super.persist});

  @override
  T parse(String value) => parseValue(value);

  @override
  String stringify(T value) => stringifyValue(value);
}
