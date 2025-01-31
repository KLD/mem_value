import 'package:mem_value/mem_value.dart';

class NMemChoices<T> extends MemChoices<T?> {
  NMemChoices(super.memValue, {required List<T> choices})
      : super(choices: [null, ...choices]);
}
