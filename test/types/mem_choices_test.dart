import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  var defaultValue = 0;
  var valueA = 1;
  var valueB = 2;

  group("MemChoices initlization", () {
    test('MemChoices throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB]);

      expect(() => memInt.value, throwsA(isA<MemValueError>()));
    });

    test('MemChoices initlize with value contained in choices', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = MemChoices(MemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB])
        ..load();

      expect(memInt.value, valueA);
    });

    test('MemChoices initlize with value contained in choices errors', () {
      MemValue.setStorage(createFakeStorage());

      expect(() {
        MemChoices(MemInt("test"), choices: [valueA, valueB]);
      }, throwsA(isA<AssertionError>()));
    });

    test('MemChoices set value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueA;
      expect(memInt.value, valueA);
    });

    test('MemChoices set value not allowed', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();

      expect(() => memInt.value = 10, throwsA(isA<MemValueError>()));
    });

    test('MemChoices set value not allowed with custom areEqual', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemChoices(MemInt("test"),
          choices: [defaultValue, valueA, valueB], areEqual: (a, b) => a == b)
        ..load();

      expect(() => memInt.value = 10, throwsA(isA<MemValueError>()));
    });

    test('MemChoices serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemChoices serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueA;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemChoices serilize and deserialize another assigned value',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memInt =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memInt.value = valueB;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemChoices reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue =
          MemChoices(MemInt("test"), choices: [defaultValue, valueA, valueB])
            ..load();
      memValue.reset();
      expect(memValue.value, defaultValue);
    });

    test('MemChoices reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemChoices(MemInt("test", initValue: valueA),
          choices: [defaultValue, valueA, valueB])
        ..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("MemChoice wraps all methods", () {
    test("Wraps methods & values ", () {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();
      expect(memValue.initValue, memChoice.initValue);
      expect(memValue.persist, memChoice.persist);
      expect(memValue.tag, memChoice.tag);
      expect(memValue.value, memChoice.value);
      expect(memValue.stringify(valueA), memChoice.stringify(valueA));
      expect(memValue.parse("1"), memChoice.parse("1"));
    });

    test("set value", () {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();

      memChoice.value = valueB;

      expect(memValue.value, valueB);
    });
    test("set value using setValue", () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();
      await memChoice.setValue(valueB);
      expect(memValue.value, valueB);
    });
    test("save calls memValue.save", () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();

      await memChoice.save();
      await memValue.load();
      expect(memValue.value, memValue.initValue);
    });
    test("resets memValue", () {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();

      memChoice.value = valueB;
      memChoice.reset();

      expect(memValue.value, memValue.initValue);
    });
    test("resets delete", () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      var memChoice =
          MemChoices(memValue, choices: [defaultValue, valueA, valueB])..load();

      await memChoice.delete();
      await memValue.load();

      expect(memValue.value, memValue.initValue);
    });
  });
}
