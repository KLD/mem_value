import '../core/mem_value.dart';

/// A nullable [MemValue] implementation for [int]
class NMemInt extends MemValue<int?> {
  /// Creates a [NMemInt] instance
  NMemInt(super.tag, {super.initValue, super.ignoreReset});

  @override
  int? parse(String value) => int.tryParse(value);

  @override
  String stringify(int value) => value.toString();

  void increment([int amount = 1]) => value = value! + amount;
  void decrement([int amount = 1]) => value = value! - amount;
}
