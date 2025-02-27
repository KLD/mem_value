import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() async {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('MemDouble throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDouble("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('MemDouble initlize with 0', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDouble("test");
    await memValue.load();

    expect(memValue.value, 0);
  });

  test('MemDouble initlize with 1', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDouble("test", initValue: 1);
    await memValue.load();
    expect(memValue.value, 1);
  });

  test('MemDouble set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDouble("test");
    await memValue.load();
    memValue.value = 1;
    expect(memValue.value, 1);
  });

  test('MemDouble serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test");
    await memValue.load();
    memValue.value = 1;
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('MemDouble increment', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test");
    await memValue.load();
    memValue.increment();
    expect(memValue.value, 1);
  });

  test('MemDouble decrement', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test");
    await memValue.load();
    memValue.decrement();
    expect(memValue.value, -1);
  });

  test('MemDouble increment with amount', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test");
    await memValue.load();
    memValue.increment(5);
    expect(memValue.value, 5);
  });

  test('MemDouble decrement with amount', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test");
    await memValue.load();
    memValue.decrement(5);
    expect(memValue.value, -5);
  });

  test('MemDouble reset', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDouble("test", initValue: 10);
    await memValue.load();
    memValue.value = 8;
    memValue.reset();
    expect(memValue.value, 10);
  });
}
