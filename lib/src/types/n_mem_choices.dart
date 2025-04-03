import 'package:mem_value/mem_value.dart';

/// A nullable [MemChoices] implementation for [T]
class NMemChoices<T> extends MemChoices<T?> {
  /// Creates a [NMemChoices] instance
  NMemChoices(super.memValue, {required List<T> choices})
      : super(choices: [null, ...choices]);
}
