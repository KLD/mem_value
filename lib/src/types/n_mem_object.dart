import '../core/mem_serializable.dart';
import '../core/mem_value.dart';
import '../exception/mem_value_exception.dart';

/// Uses [MemSerializable] to store and retrieve a custom object.
class NMemObject<T extends MemSerializable> extends MemValue<T?> {
  final MemSerializable? parser;

  NMemObject(
    super.tag, {
    super.initValue,
    super.persist,
    this.parser,
  });

  @override
  T parse(String value) {
    if (this.value == null && initValue == null && parser != null) {
      throw MemValueException(
          "NMemObject: $tag must either have inital value or a parser");
    }
    return parser?.parse(value) ??
        initValue?.parse(value) ??
        this.value!.parse(value);
  }

  @override
  String stringify(T value) {
    if (this.value == null && initValue == null && parser != null) {
      throw MemValueException(
          "NMemObject: $tag must either have inital value or a parser");
    }

    return parser?.stringify(value) ??
        initValue?.stringify(value) ??
        this.value!.stringify(value);
  }
}
