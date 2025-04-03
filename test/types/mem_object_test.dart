import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

class MockObject with MemSerializable {
  final int a;
  const MockObject(this.a);

  @override
  MockObject parse(String value) => MockObject(jsonDecode(value)['a']);

  @override
  String stringify(value) => jsonEncode({'a': value.a});
}

void main() async {
  tearDown(() async {
    MemValue.clearIds();
  });

  var initValue = const MockObject(0);
  var valueA = const MockObject(1);
  var valueB = const MockObject(2);

  group("MemObject initlization", () {
    test('MemObject throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemObject("test", initValue: initValue);

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('MemObject initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();

      expect(memValue.value, initValue);
    });

    test('MemObject initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemObject("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('MemObject set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('MemObject serilize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();
      memValue.stringify(memValue.value);
      expect(true, true);
    });
    test('MemObject serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value.a, value.a);
    });

    test('MemObject serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value.a, value.a);
    });

    test('MemObject serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemObject("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value.a, value.a);
    });
  });
}
