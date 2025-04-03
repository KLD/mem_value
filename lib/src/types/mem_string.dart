import '../core/mem_value.dart';

/// A [MemValue] implementation for [String]
class MemString extends MemValue<String> {
  /// Creates a new [MemString] instance
  MemString(super.tag, {super.initValue = '', super.ignoreReset});

  @override
  String parse(String value) => value;

  @override
  String stringify(String value) => value;
}
