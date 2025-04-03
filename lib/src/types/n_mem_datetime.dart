import '../core/mem_value.dart';

/// A [MemValue] implementation for [DateTime?]
class NMemDateTime extends MemValue<DateTime?> {
  /// Creates a [NMemDateTime] instance
  NMemDateTime(super.tag, {super.initValue, super.ignoreReset});

  @override
  DateTime? parse(String value) => DateTime.tryParse(value);

  @override
  String stringify(DateTime value) => value.toIso8601String();
}
