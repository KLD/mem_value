import '../core/mem_value.dart';

class NMemDouble extends MemValue<double?> {
  NMemDouble(super.tag, {super.initValue, super.persist});

  @override
  double? parse(String value) => double.tryParse(value);

  @override
  String stringify(double value) => value.toString();

  void increment([double amount = 1]) => value = value! + amount;
  void decrement([double amount = 1]) => value = value! - amount;
}
