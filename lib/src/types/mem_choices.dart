import 'package:mem_value/src/error/mem_value_error.dart';

import '../core/mem_value.dart';

class MemChoices<T> implements MemValue<T> {
  final List<T> choices;
  final MemValue<T> memValue;
  final bool Function(T, T)? areEqual;

  MemChoices(
    this.memValue, {
    required this.choices,
    this.areEqual,
  }) {
    assert(choices.isNotEmpty);
    assert(choices.contains(memValue.initValue));
  }

  @override
  set value(value) {
    if (areEqual != null && choices.where((e) => areEqual!(e, value)).isEmpty) {
      throw MemValueError("$value is not included in choices: $choices");
    }
    if (!choices.contains(value)) {
      throw MemValueError("$value is not included in choices: $choices");
    }
    memValue.value = value;
  }

  @override
  T get value => memValue.value;

  @override
  T parse(String value) => memValue.parse(value);

  @override
  String stringify(T value) => memValue.stringify(value);

  @override
  T get initValue => memValue.initValue;

  @override
  Future<void> load() => memValue.load();

  @override
  bool get persist => memValue.persist;

  @override
  Future<void> reset() => memValue.reset();

  @override
  Future<void> save() => memValue.save();

  @override
  String get tag => memValue.tag;

  @override
  Future<void> setValue(T value) => memValue.setValue(value);

  @override
  Future<void> deleteTag() => memValue.deleteTag();
}
