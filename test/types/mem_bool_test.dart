import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('MemBool throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemBool("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('MemBool initlize with false', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemBool("test");
    await memValue.load();

    expect(memValue.value, false);
  });

  test('MemBool initlize with true', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemBool("test", initValue: true);
    await memValue.load();
    expect(memValue.value, true);
  });

  test('MemBool set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemBool("test");
    await memValue.load();
    memValue.value = true;
    expect(memValue.value, true);
  });

  test('MemBool serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test");
    await memValue.load();
    memValue.value = false;
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('MemBool toggle', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test");
    await memValue.load();
    memValue.toggle();
    expect(memValue.value, true);
    memValue.toggle();
    expect(memValue.value, false);
  });

  test('MemBool on', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test");
    await memValue.load();
    memValue.on();
    expect(memValue.value, true);
  });

  test('MemBool off', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test", initValue: true);
    await memValue.load();
    memValue.off();
    expect(memValue.value, false);
  });

  test('MemBool resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test", initValue: true);
    await memValue.load();
    memValue.value = false;
    await memValue.reset();
    expect(memValue.value, true);
  });
  test('MemBool resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test");
    await memValue.load();
    memValue.value = true;
    await memValue.reset();
    expect(memValue.value, false);
  });

  test('MemBool parse throws error', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemBool("test");
    await memValue.load();

    expect(() => memValue.parse("notBool"), throwsA(isFormatException));
  });
}
