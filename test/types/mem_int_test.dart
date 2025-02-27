import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() async {
  tearDown(() async {
    MemValue.clearIds();
  });

  var defaultInitliazedValue = 0;
  var valueA = 1;
  var valueB = 2;

  group("memValue initlization", () async {
    test('memValue throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemInt("test");

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('memValue initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemInt("test");
      await memValue.load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('memValue initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemInt("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('memValue set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemInt("test");
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('memValue serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('memValue serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('memValue serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('memValue reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('memValue reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test", initValue: valueA);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("memValue addtional methods", () async {
    test('memValue increment', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.increment();
      expect(memValue.value, 1);
    });

    test('memValue decrement', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.decrement();
      expect(memValue.value, -1);
    });

    test('memValue increment with amount', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.increment(5);
      expect(memValue.value, 5);
    });

    test('memValue decrement with amount', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test");
      await memValue.load();
      memValue.decrement(5);
      expect(memValue.value, -5);
    });

    test('memValue reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemInt("test", initValue: 10);
      await memValue.load();
      memValue.value = 8;
      memValue.reset();
      expect(memValue.value, 10);
    });
  });
}
