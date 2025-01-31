import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

void main() {
  var initValue = "";
  parse(String value) => value;
  stringify(String value) => value;
  test('MemCustom throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('MemCustom initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();

    expect(memInt.value, "");
  });
  test('MemCustom initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();

    expect(memInt.value, initValue);
  });

  test('MemCustom set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    expect(memInt.value, "new");
  });

  test('MemCustom serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('MemCustom resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, "");
  });

  test('MemCustom resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, initValue);
  });
}
