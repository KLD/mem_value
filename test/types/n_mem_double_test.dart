import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('NMemDouble throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDouble("test");

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });

  test('NMemDouble initlize with 0', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDouble("test")..load();

    expect(memInt.value, null);
  });

  test('NMemDouble initlize with 1', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDouble("test", initValue: 1)..load();
    expect(memInt.value, 1);
  });

  test('NMemDouble set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDouble("test")..load();
    memInt.value = 1;
    expect(memInt.value, 1);
  });

  test('NMemDouble serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDouble("test")..load();
    memInt.value = 1;
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('NMemDouble increment', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDouble("test")..load();
    expect(() => memInt.increment(), throwsA(isA<TypeError>()));
  });

  test('NMemDouble decrement', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDouble("test")..load();
    expect(() => memInt.decrement(), throwsA(isA<TypeError>()));
  });

  test('NMemDouble reset', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDouble("test")..load();
    memInt.value = 8;
    memInt.reset();
    expect(memInt.value, null);
  });

  test('NMemDouble reset to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDouble("test", initValue: 2)..load();
    memInt.value = 8;
    memInt.reset();
    expect(memInt.value, 2);
  });
}
