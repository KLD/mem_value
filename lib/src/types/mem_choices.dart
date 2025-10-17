import 'package:mem_value/src/exception/mem_value_exception.dart';

import '../core/mem_value.dart';

/// Resticts mem value to a set of choices
class MemChoices<T> implements MemValue<T> {
  /// Value MemValue can be assigned to.
  final List<T> choices;

  /// MemValue to restrict
  final MemValue<T> memValue;

  /// Used to compare current value with value of choices.
  final bool Function(T, T)? areEqual;

  /// Creates a new [MemChoices] instance
  MemChoices(
    this.memValue, {
    required this.choices,
    this.areEqual,
  }) {
    assert(choices.isNotEmpty);
    assert(choices.contains(memValue.initValue));
  }

  /// sets value to [value] if it is included in [choices]
  @override
  set value(value) {
    if (areEqual != null && choices.where((e) => areEqual!(e, value)).isEmpty) {
      throw MemValueException("$value is not included in choices: $choices");
    }
    if (!choices.contains(value)) {
      throw MemValueException("$value is not included in choices: $choices");
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
  Future<void> load([bool skipIfLoaded = true]) => memValue.load(skipIfLoaded);

  @override
  bool get ignoreReset => memValue.ignoreReset;

  @override
  Future<void> reset() => memValue.reset();

  @override
  Future<void> save() => memValue.save();

  @override
  String get tag => memValue.tag;

  @override
  Future<void> setValue(T value) => memValue.setValue(value);

  @override
  Future<T> read() => memValue.read();

  @override
  Future<void> delete() => memValue.delete();
}
