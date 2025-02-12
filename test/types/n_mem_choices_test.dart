import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  // ignore: avoid_init_to_null
  var defaultValue = null;
  var valueA = 1;
  var valueB = 2;

  group("NMemChoices initlization", () {
    test('NMemChoices throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemChoices(NMemInt("test"), choices: [valueA, valueB]);

      expect(() => memInt.value, throwsA(isA<MemValueError>()));
    });

    test('NMemChoices initlize with value contained in choices', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemChoices(NMemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB])
        ..load();

      expect(memInt.value, valueA);
    });

    test('NMemChoices initlize with value contained in choices errors', () {
      MemValue.setStorage(createFakeStorage());

      expect(() {
        NMemChoices(NMemInt("test", initValue: 10), choices: [valueA, valueB]);
      }, throwsA(isA<AssertionError>()));
    });

    test('NMemChoices set value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueA;
      expect(memInt.value, valueA);
    });

    test('NMemChoices serilize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();

      expect(() => memInt.stringify(memInt.value), throwsA(isA<TypeError>()));
    });
    test('NMemChoices serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();

      expect(() => memInt.parse(memInt.stringify(memInt.value)),
          throwsA(isA<TypeError>()));
    });

    test('NMemChoices serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueA;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('NMemChoices serilize and deserialize another assigned value',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueB;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('NMemChoices reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memValue.reset();
      expect(memValue.value, defaultValue);
    });

    test('NMemChoices reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemChoices(NMemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB])
        ..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });
}
