import '../core/mem_value.dart';

/// A [MemValue] implementation for [int]
class MemInt extends MemValue<int> {
  /// Creates a [MemInt] instance
  MemInt(super.tag, {super.initValue = 0, super.ignoreReset});

  @override
  int parse(String value) => int.parse(value);

  @override
  String stringify(int value) => value.toString();

  void increment([int amount = 1]) => value = value + amount;
  void decrement([int amount = 1]) => value = value - amount;
}
