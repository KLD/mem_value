import '../core/mem_value.dart';

class MemInt extends MemValue<int> {
  MemInt(super.tag, {super.initValue = 0, super.persist});

  @override
  int parse(String value) => int.parse(value);

  @override
  String stringify(int value) => value.toString();

  void increment([int amount = 1]) => value = value + amount;
  void decrement([int amount = 1]) => value = value - amount;
}
