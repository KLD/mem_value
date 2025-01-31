import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

void main() {
  test('throws error when value is not loaded', () {
    final memInt = MemInt('test');
    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('throws error when saving value without storage setup', () {
    final memInt = MemInt('test');
    expect(() => memInt.save(), throwsA(isA<MemValueError>()));
  });

  test('throws error when loading value without storage setup', () {
    final memInt = MemInt('test');
    expect(() => memInt.load(), throwsA(isA<MemValueError>()));
  });

  test('throws error when deleting value without storage setup', () {
    final memInt = MemInt('test');
    expect(() => memInt.deleteTag(), throwsA(isA<MemValueError>()));
  });

  test('when persist is true, prevent resetting value', () {
    MemValue.setStorage(createFakeStorage());
    final memInt = MemInt('test', persist: true)..load();

    memInt.value = 10;
    memInt.reset();

    expect(memInt.value, 10);
  });
}
