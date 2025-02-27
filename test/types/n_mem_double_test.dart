import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('NMemDouble throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemDouble("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });

  test('NMemDouble initlize with 0', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemDouble("test");
    await memValue.load();

    expect(memValue.value, null);
  });

  test('NMemDouble initlize with 1', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemDouble("test", initValue: 1);
    await memValue.load();
    expect(memValue.value, 1);
  });

  test('NMemDouble set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemDouble("test");
    await memValue.load();
    memValue.value = 1;
    expect(memValue.value, 1);
  });

  test('NMemDouble serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemDouble("test");
    await memValue.load();
    memValue.value = 1;
    var value = memValue.parse(memValue.stringify(memValue.value!));
    expect(memValue.value, value);
  });

  test('NMemDouble increment', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemDouble("test");
    await memValue.load();
    expect(() => memValue.increment(), throwsA(isA<TypeError>()));
  });

  test('NMemDouble decrement', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemDouble("test");
    await memValue.load();
    expect(() => memValue.decrement(), throwsA(isA<TypeError>()));
  });

  test('NMemDouble reset', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemDouble("test");
    await memValue.load();
    memValue.value = 8;
    memValue.reset();
    expect(memValue.value, null);
  });

  test('NMemDouble reset to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemDouble("test", initValue: 2);
    await memValue.load();
    memValue.value = 8;
    memValue.reset();
    expect(memValue.value, 2);
  });
}
