import 'package:mem_value/src/core/mem_serializable.dart';

import '../core/mem_value.dart';

/// Uses [MemSerializable] to store and retrieve a custom object.
class MemObject<T extends MemSerializable> extends MemValue<T> {
  MemObject(super.tag, {required super.initValue, super.persist});

  @override
  T parse(String value) => this.value.parse(value);

  @override
  String stringify(T value) => value.stringify(value);
}
