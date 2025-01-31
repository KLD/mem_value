import '../core/mem_value.dart';

class NMemBool extends MemValue<bool?> {
  NMemBool(super.tag, {super.initValue, super.persist});

  @override
  bool? parse(String value) => bool.tryParse(value);

  @override
  String stringify(bool? value) => value!.toString();

  void on() => value = true;
  void off() => value = false;
}
