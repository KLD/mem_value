import '../core/mem_value.dart';

/// A [MemValue] implementation for [double]
class MemDouble extends MemValue<double> {
  /// Creates a [MemDouble] instance
  MemDouble(super.tag, {super.initValue = 0, super.ignoreReset});

  @override
  double parse(String value) => double.parse(value);

  @override
  String stringify(double value) => value.toString();

  void increment([double amount = 1]) => value = value + amount;
  void decrement([double amount = 1]) => value = value - amount;
}
