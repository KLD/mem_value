import 'mem_custom.dart';

class NMemCustom<T> extends MemCustom<T?> {
  NMemCustom(super.tag,
      {required super.parseValue,
      required super.stringifyValue,
      super.initValue});
}
