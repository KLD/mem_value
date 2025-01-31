import '../core/mem_value.dart';

class NMemDateTime extends MemValue<DateTime?> {
  NMemDateTime(super.tag, {super.initValue, super.persist});

  @override
  DateTime? parse(String value) => DateTime.tryParse(value);

  @override
  String stringify(DateTime? value) => value!.toIso8601String();
}
