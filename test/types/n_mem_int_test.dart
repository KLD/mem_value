import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  // ignore: avoid_init_to_null
  var defaultInitliazedValue = null;
  var valueA = 1;
  var valueB = 2;

  group("NmemValue initlization", () {
    test('NmemValue throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemInt("test");

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('NmemValue initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemInt("test");
      await memValue.load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('NmemValue initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemInt("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('NmemValue set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemInt("test");
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NmemValue serilize and deserialize throw error without initlization',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();

      expect(() => memValue.parse(memValue.stringify(memValue.value!)),
          throwsA(isA<TypeError>()));
    });

    test('NmemValue serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value, value);
    });

    test('NmemValue serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value, value);
    });

    test('NmemValue reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('NmemValue reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test", initValue: valueA);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("NmemValue addtional methods", () {
    test('NmemValue increment', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();
      expect(() => memValue.increment(), throwsA(isA<TypeError>()));
    });

    test('NmemValue decrement', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test");
      await memValue.load();
      expect(() => memValue.decrement(), throwsA(isA<TypeError>()));
    });

    test('NmemValue reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemInt("test", initValue: 10);
      await memValue.load();
      memValue.value = 8;
      memValue.reset();
      expect(memValue.value, 10);
    });
  });
}
