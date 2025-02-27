import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('NMemBool throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemBool("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('NMemBool initlize with null', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemBool("test");
    await memValue.load();

    expect(memValue.value, null);
  });

  test('NMemBool initlize with true', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemBool("test", initValue: true);
    await memValue.load();
    expect(memValue.value, true);
  });

  test('NMemBool set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemBool("test");
    await memValue.load();
    memValue.value = true;
    expect(memValue.value, true);
  });

  test('NMemBool serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemBool("test");
    await memValue.load();
    memValue.value = false;
    var value = memValue.parse(memValue.stringify(memValue.value!));
    expect(memValue.value, value);
  });

  test('NMemBool on', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemBool("test");
    await memValue.load();
    memValue.on();
    expect(memValue.value, true);
  });

  test('NMemBool off', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemBool("test", initValue: true);
    await memValue.load();
    memValue.off();
    expect(memValue.value, false);
  });

  test('NMemBool resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemBool("test", initValue: true);
    await memValue.load();
    memValue.value = false;
    memValue.reset();
    expect(memValue.value, true);
  });
  test('NMemBool resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemBool("test");
    await memValue.load();
    memValue.value = true;
    memValue.reset();
    expect(memValue.value, null);
  });
}
