import '../core/mem_value.dart';

/// A nullable [MemValue] implementation for [double]
class NMemDouble extends MemValue<double?> {
  /// Creates a [NMemDouble] instance
  NMemDouble(super.tag, {super.initValue, super.ignoreReset});

  @override
  double? parse(String value) => double.tryParse(value);

  @override
  String stringify(double value) => value.toString();

  void increment([double amount = 1]) => value = value! + amount;
  void decrement([double amount = 1]) => value = value! - amount;
}
