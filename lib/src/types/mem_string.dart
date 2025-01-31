import '../core/mem_value.dart';

class MemString extends MemValue<String> {
  MemString(super.tag, {super.initValue = '', super.persist});

  @override
  String parse(String value) => value;

  @override
  String stringify(String value) => value;
}
