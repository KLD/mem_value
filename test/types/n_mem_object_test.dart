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

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  // ignore: avoid_init_to_null
  MockObject? initValue = null;
  var valueA = const MockObject(1);
  var valueB = const MockObject(2);

  group("NMemObject initlization", () {
    test('NMemObject throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue);

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('NMemObject initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue);
      await memValue.load();

      expect(memValue.value, initValue);
    });

    test('NMemObject initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('NMemObject set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemObject<MockObject>("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemObject serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value?.a, value.a);
    });

    test('NMemObject serilize and deserialize another assigned value',
        () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemObject<MockObject>("test", initValue: initValue);
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value?.a, value.a);
    });
  });
}
