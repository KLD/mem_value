import '../core/mem_value.dart';

class NMemString extends MemValue<String?> {
  NMemString(super.tag, {super.initValue, super.persist});

  @override
  String? parse(String value) => value;

  @override
  String stringify(String value) => value;
}
