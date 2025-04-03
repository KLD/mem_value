import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });
  test('throws error when value is not loaded', () async {
    final memValue = MemInt('test');
    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('throws error when saving value without storage setup', () async {
    final memValue = MemInt('test');
    expect(() => memValue.save(), throwsA(isA<MemValueException>()));
  });

  test('throws error when loading value without storage setup', () async {
    final memValue = MemInt('test');
    expect(() => memValue.load(), throwsA(isA<MemValueException>()));
  });

  test('throws error when deleting value without storage setup', () async {
    final memValue = MemInt('test');
    expect(() => memValue.delete(), throwsA(isA<MemValueException>()));
  });

  test('when ignoreReset is true, prevent resetting value', () async {
    MemValue.setStorage(createFakeStorage());
    final memValue = MemInt('test', ignoreReset: true);
    await memValue.load();

    memValue.value = 10;
    memValue.reset();

    expect(memValue.value, 10);
  });

  test("Duplicate keys throw an error", () {
    MemInt("test");

    expect(() => MemBool("test"), throwsA(isA<MemValueException>()));
  });
}
