import 'mem_custom.dart';

/// A nullable [MemCustom] implementation for [T]
class NMemCustom<T> extends MemCustom<T?> {
  /// Creates a [NMemCustom] instance
  NMemCustom(super.tag,
      {required super.parseValue,
      required super.stringifyValue,
      super.initValue});
}
