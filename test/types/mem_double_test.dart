import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

void main() {
  test('MemDouble throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDouble("test");

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('MemDouble initlize with 0', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDouble("test")..load();

    expect(memInt.value, 0);
  });

  test('MemDouble initlize with 1', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDouble("test", initValue: 1)..load();
    expect(memInt.value, 1);
  });

  test('MemDouble set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDouble("test")..load();
    memInt.value = 1;
    expect(memInt.value, 1);
  });

  test('MemDouble serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test")..load();
    memInt.value = 1;
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('MemDouble increment', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test")..load();
    memInt.increment();
    expect(memInt.value, 1);
  });

  test('MemDouble decrement', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test")..load();
    memInt.decrement();
    expect(memInt.value, -1);
  });

  test('MemDouble increment with amount', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test")..load();
    memInt.increment(5);
    expect(memInt.value, 5);
  });

  test('MemDouble decrement with amount', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test")..load();
    memInt.decrement(5);
    expect(memInt.value, -5);
  });

  test('MemDouble reset', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDouble("test", initValue: 10)..load();
    memInt.value = 8;
    memInt.reset();
    expect(memInt.value, 10);
  });
}
