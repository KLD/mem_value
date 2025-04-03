import '../core/mem_value.dart';

/// A nullable [MemValue] implementation for [String]
class NMemString extends MemValue<String?> {
  NMemString(super.tag, {super.initValue, super.ignoreReset});

  @override
  String? parse(String value) => value;

  @override
  String stringify(String value) => value;
}
