import '../core/mem_value.dart';

/// A [MemValue] implementation for [DateTime]
class MemDateTime extends MemValue<DateTime> {
  /// Creates a [MemDateTime] instance
  MemDateTime(super.tag, {required super.initValue, super.ignoreReset});

  @override
  DateTime parse(String value) => DateTime.parse(value);

  @override
  String stringify(DateTime value) => value.toIso8601String();
}
