import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  // ignore: avoid_init_to_null
  var initValue = null;
  var valueA = "a";
  String? parse(String value) => value;
  String stringify(String? value) => value!;

  test('NMemCustom throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify);

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });

  test('NMemCustom initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt =
        NMemCustom<String>("test", parseValue: parse, stringifyValue: stringify)
          ..load();

    expect(memInt.value, null);
  });
  test('NMemCustom initlize with initValue', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();

    expect(memInt.value, initValue);
  });

  test('NMemCustom set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = valueA;
    expect(memInt.value, valueA);
  });

  test('NMemCustom serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('NMemCustom resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemCustom<String>("test",
        initValue: valueA, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, valueA);
  });

  test('NMemCustom resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemCustom<String>("test",
        initValue: initValue, parseValue: parse, stringifyValue: stringify)
      ..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, initValue);
  });
}
