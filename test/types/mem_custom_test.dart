import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  var initValue = "";
  parse(String value) => value;
  stringify(String value) => value;

  test('MemCustom throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('MemCustom initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    await memValue.load();

    expect(memValue.value, "");
  });
  test('MemCustom initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    await memValue.load();

    expect(memValue.value, initValue);
  });

  test('MemCustom set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();

    memValue.value = "new";
    expect(memValue.value, "new");
  });

  test('MemCustom serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('MemCustom resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, "");
  });

  test('MemCustom resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemCustom("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, initValue);
  });
}
