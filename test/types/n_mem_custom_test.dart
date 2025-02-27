import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  // ignore: avoid_init_to_null
  var initValue = null;
  var valueA = "a";
  String? parse(String value) => value;
  String stringify(String? value) => value!;

  test('NMemCustom throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });

  test('NMemCustom initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemCustom<String>("test",
        parseValue: parse, stringifyValue: stringify);
    await memValue.load();

    expect(memValue.value, null);
  });
  test('NMemCustom initlize with initValue', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();

    expect(memValue.value, initValue);
  });

  test('NMemCustom set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = valueA;
    expect(memValue.value, valueA);
  });

  test('NMemCustom serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('NMemCustom resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemCustom<String>("test",
        initValue: valueA, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, valueA);
  });

  test('NMemCustom resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, initValue);
  });
}
