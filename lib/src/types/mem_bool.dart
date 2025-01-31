import '../core/mem_value.dart';

class MemBool extends MemValue<bool> {
  MemBool(super.tag, {super.initValue = false, super.persist});

  @override
  bool parse(String value) => bool.parse(value);

  @override
  String stringify(bool value) => value.toString();

  void toggle() => value = !value;
  void on() => value = true;
  void off() => value = false;
}
