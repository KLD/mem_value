import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

void main() {
  var defaultInitliazedValue = 0;
  var valueA = 1;
  var valueB = 2;

  group("MemInt initlization", () {
    test('MemInt throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = MemInt("test");

      expect(() => memInt.value, throwsA(isA<MemValueError>()));
    });
    test('MemInt initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = MemInt("test")..load();

      expect(memInt.value, defaultInitliazedValue);
    });

    test('MemInt initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = MemInt("test", initValue: valueA)..load();
      expect(memInt.value, valueA);
    });

    test('MemInt set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memInt = MemInt("test")..load();
      memInt.value = valueA;
      expect(memInt.value, valueA);
    });

    test('MemInt serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemInt serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.value = valueA;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemInt serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.value = valueB;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('MemInt reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test")..load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemInt reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test", initValue: valueA)..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("MemInt addtional methods", () {
    test('MemInt increment', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.increment();
      expect(memInt.value, 1);
    });

    test('MemInt decrement', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.decrement();
      expect(memInt.value, -1);
    });

    test('MemInt increment with amount', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.increment(5);
      expect(memInt.value, 5);
    });

    test('MemInt decrement with amount', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test")..load();
      memInt.decrement(5);
      expect(memInt.value, -5);
    });

    test('MemInt reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = MemInt("test", initValue: 10)..load();
      memInt.value = 8;
      memInt.reset();
      expect(memInt.value, 10);
    });
  });
}
