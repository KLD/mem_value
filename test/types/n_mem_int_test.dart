import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  // ignore: avoid_init_to_null
  var defaultInitliazedValue = null;
  var valueA = 1;
  var valueB = 2;

  group("NMemInt initlization", () {
    test('NMemInt throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemInt("test");

      expect(() => memInt.value, throwsA(isA<MemValueError>()));
    });
    test('NMemInt initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemInt("test")..load();

      expect(memInt.value, defaultInitliazedValue);
    });

    test('NMemInt initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemInt("test", initValue: valueA)..load();
      expect(memInt.value, valueA);
    });

    test('NMemInt set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memInt = NMemInt("test")..load();
      memInt.value = valueA;
      expect(memInt.value, valueA);
    });

    test('NMemInt serilize and deserialize throw error without initlization',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test")..load();

      expect(() => memInt.parse(memInt.stringify(memInt.value)),
          throwsA(isA<TypeError>()));
    });

    test('NMemInt serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test")..load();
      memInt.value = valueA;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('NMemInt serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test")..load();
      memInt.value = valueB;
      var value = memInt.parse(memInt.stringify(memInt.value));
      expect(memInt.value, value);
    });

    test('NMemInt reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test")..load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('NMemInt reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test", initValue: valueA)..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("NMemInt addtional methods", () {
    test('NMemInt increment', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test")..load();
      expect(() => memInt.increment(), throwsA(isA<TypeError>()));
    });

    test('NMemInt decrement', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test")..load();
      expect(() => memInt.decrement(), throwsA(isA<TypeError>()));
    });

    test('NMemInt reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memInt = NMemInt("test", initValue: 10)..load();
      memInt.value = 8;
      memInt.reset();
      expect(memInt.value, 10);
    });
  });
}
