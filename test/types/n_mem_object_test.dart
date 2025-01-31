import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';
import 'package:mem_value/src/core/mem_serializable.dart';
import 'package:mem_value/src/error/mem_value_error.dart';

import '../helper.dart';

class MockObject with MemSerializable {
  final int a;
  const MockObject(this.a);

  @override
  MockObject parse(String value) => MockObject(jsonDecode(value)['a']);

  @override
  String stringify(value) => jsonEncode({'a': value.a});
}

void main() {
  // ignore: avoid_init_to_null
  var initValue = null;
  var valueA = const MockObject(1);
  var valueB = const MockObject(2);

  group("NMemObject initlization", () {
    test('NMemObject throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue);

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('NMemObject initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();

      expect(memValue.value, initValue);
    });

    test('NMemObject initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('NMemObject set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemObject serilize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();
      memValue.stringify(memValue.value);
      expect(true, true);
    });
    test('NMemObject serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value?.a, value.a);
    });

    test('NMemObject serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value?.a, value.a);
    });

    test('NMemObject serilize and deserialize another assigned value',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue)
        ..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value?.a, value.a);
    });
  });
}
