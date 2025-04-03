import '../core/mem_value.dart';

/// A [MemValue] implementation for [bool]
class MemBool extends MemValue<bool> {
  /// Creates a [MemBool] instance
  MemBool(super.tag, {super.initValue = false, super.ignoreReset});

  @override
  bool parse(String value) => bool.parse(value);

  @override
  String stringify(bool value) => value.toString();

  /// Toggles the value
  void toggle() => value = !value;

  /// Turns the value to true
  void on() => value = true;

  /// Turns the value to false
  void off() => value = false;
}
