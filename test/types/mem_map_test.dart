import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  Map defaultInitliazedValue = const {};
  var valueA = const <dynamic, dynamic>{'A': 'a'};
  var valueB = const <dynamic, dynamic>{'B': 'b'};

  group("MemMap initlization", () {
    test('MemMap throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemMap("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('MemMap initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemMap("test")..load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemMap initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemMap("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('MemMap set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemMap("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('MemMap serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test")..load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemMap serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemMap serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });
  });

  group("MemMap addtional methods", () {
    test('MemMap add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test")..load();
      memValue.add('C', 'c');
      expect(memValue.value['C'], 'c');
    });

    test('MemMap addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test")..load();
      memValue.addAll({
        'C': 'c',
        'D': 'd',
      });
      expect(memValue.value, {
        'C': 'c',
        'D': 'd',
      });
    });

    test('MemMap remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test", initValue: {'a': "A"})..load();
      memValue.remove('a');
      expect(memValue.value, {});
    });

    test('MemMap clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemMap("test", initValue: {'a': "A"})..load();
      memValue.clear();
      expect(memValue.value, {});
    });
  });
}
