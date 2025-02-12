import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('NMemBool throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemBool("test");

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('NMemBool initlize with null', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemBool("test")..load();

    expect(memInt.value, null);
  });

  test('NMemBool initlize with true', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemBool("test", initValue: true)..load();
    expect(memInt.value, true);
  });

  test('NMemBool set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemBool("test")..load();
    memInt.value = true;
    expect(memInt.value, true);
  });

  test('NMemBool serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemBool("test")..load();
    memInt.value = false;
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('NMemBool on', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemBool("test")..load();
    memInt.on();
    expect(memInt.value, true);
  });

  test('NMemBool off', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemBool("test", initValue: true)..load();
    memInt.off();
    expect(memInt.value, false);
  });

  test('NMemBool resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemBool("test", initValue: true)..load();
    memInt.value = false;
    memInt.reset();
    expect(memInt.value, true);
  });
  test('NMemBool resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemBool("test")..load();
    memInt.value = true;
    memInt.reset();
    expect(memInt.value, null);
  });
}
