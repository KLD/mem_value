import '../core/mem_value.dart';

/// A nullable [MemValue] implementation for [bool]
class NMemBool extends MemValue<bool?> {
  /// Creates a [NMemBool] instance
  NMemBool(super.tag, {super.initValue, super.ignoreReset});

  @override
  bool? parse(String value) => bool.tryParse(value);

  @override
  String stringify(bool value) => value.toString();

  /// Sets value to true
  Future<void> on() => setValue(true);

  /// Sets value to false
  Future<void> off() => setValue(false);
}
