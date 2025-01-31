import '../core/mem_value.dart';

class MemDateTime extends MemValue<DateTime> {
  MemDateTime(super.tag, {required super.initValue, super.persist});

  @override
  DateTime parse(String value) => DateTime.parse(value);

  @override
  String stringify(DateTime value) => value.toIso8601String();
}
