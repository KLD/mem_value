import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  // ignore: avoid_init_to_null
  var defaultValue = null;
  var valueA = 1;
  var valueB = 2;

  group("NMemChoices initlization", () {
    test('NMemChoices throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemChoices(NMemInt("test"), choices: [valueA, valueB]);

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });

    test('NMemChoices initlize with value contained in choices', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemChoices(NMemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB]);
      await memValue.load();

      expect(memValue.value, valueA);
    });

    test('NMemChoices initlize with value contained in choices errors',
        () async {
      MemValue.setStorage(createFakeStorage());

      expect(() {
        NMemChoices(NMemInt("test", initValue: 10), choices: [valueA, valueB]);
      }, throwsA(isA<AssertionError>()));
    });

    test('NMemChoices set value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemChoices serilize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();

      expect(
          () => memValue.stringify(memValue.value), throwsA(isA<TypeError>()));
    });
    test('NMemChoices serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();

      expect(() => memValue.parse(memValue.stringify(memValue.value)),
          throwsA(isA<TypeError>()));
    });

    test('NMemChoices serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemChoices serilize and deserialize another assigned value',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemChoices reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          NMemChoices(NMemInt("test"), choices: [defaultValue, valueA, valueB]);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, defaultValue);
    });

    test('NMemChoices reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemChoices(NMemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB]);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });
}
