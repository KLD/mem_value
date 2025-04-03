import 'package:mem_value/src/core/mem_serializable.dart';

import '../core/mem_value.dart';

/// A [MemValue] implementation for [MemSerializable]
class MemObject<T extends MemSerializable> extends MemValue<T> {
  MemObject(super.tag, {required super.initValue, super.ignoreReset});

  @override
  T parse(String value) => this.value.parse(value);

  @override
  String stringify(T value) => value.stringify(value);
}
