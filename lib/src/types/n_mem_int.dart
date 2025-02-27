import '../core/mem_value.dart';

class NMemInt extends MemValue<int?> {
  NMemInt(super.tag, {super.initValue, super.persist});

  @override
  int? parse(String value) => int.tryParse(value);

  @override
  String stringify(int value) => value.toString();

  void increment([int amount = 1]) => value = value! + amount;
  void decrement([int amount = 1]) => value = value! - amount;
}
