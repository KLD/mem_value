import '../core/mem_serializable.dart';
import '../core/mem_value.dart';

/// Uses [MemSerializable] to store and retrieve a custom object.
class NMemObject<T extends MemSerializable> extends MemValue<T?> {
  NMemObject(super.tag, {super.initValue, super.persist});

  @override
  T parse(String value) => this.value!.parse(value);

  @override
  String stringify(T? value) => value!.stringify(value);
}
