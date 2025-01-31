import '../core/mem_value.dart';

class MemDouble extends MemValue<double> {
  MemDouble(super.tag, {super.initValue = 0, super.persist});

  @override
  double parse(String value) => double.parse(value);

  @override
  String stringify(double value) => value.toString();

  void increment([double amount = 1]) => value = value + amount;
  void decrement([double amount = 1]) => value = value - amount;
}
