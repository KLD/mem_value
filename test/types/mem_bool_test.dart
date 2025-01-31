import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

void main() {
  test('MemBool throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemBool("test");

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('MemBool initlize with false', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemBool("test")..load();

    expect(memInt.value, false);
  });

  test('MemBool initlize with true', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemBool("test", initValue: true)..load();
    expect(memInt.value, true);
  });

  test('MemBool set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemBool("test")..load();
    memInt.value = true;
    expect(memInt.value, true);
  });

  test('MemBool serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test")..load();
    memInt.value = false;
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('MemBool toggle', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test")..load();
    memInt.toggle();
    expect(memInt.value, true);
    memInt.toggle();
    expect(memInt.value, false);
  });

  test('MemBool on', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test")..load();
    memInt.on();
    expect(memInt.value, true);
  });

  test('MemBool off', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test", initValue: true)..load();
    memInt.off();
    expect(memInt.value, false);
  });

  test('MemBool resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test", initValue: true)..load();
    memInt.value = false;
    memInt.reset();
    expect(memInt.value, true);
  });
  test('MemBool resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test")..load();
    memInt.value = true;
    memInt.reset();
    expect(memInt.value, false);
  });

  test('MemBool parse throws error', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemBool("test")..load();

    expect(() => memInt.parse("notBool"), throwsA(isFormatException));
  });
}
