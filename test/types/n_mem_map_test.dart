import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  var valueA = const <dynamic, dynamic>{'A': 'a'};
  var valueB = const <dynamic, dynamic>{'B': 'b'};

  group("NMemMap initlization", () {
    test('NMemMap throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemMap("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('NMemMap initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemMap("test")..load();

      expect(memValue.value, null);
    });

    test('NMemMap initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemMap("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('NMemMap set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemMap("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemMap serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test")..load();

      expect(() => memValue.parse(memValue.stringify(memValue.value)),
          throwsA(isA<NoSuchMethodError>()));
    });

    test('NMemMap serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemMap serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });
  });

  group("NMemMap addtional methods", () {
    test('NMemMap add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test")..load();

      expect(() {
        memValue.add('C', 'c');

        expect(memValue.value!['C'], 'c');
      }, throwsA(isA<TypeError>()));
    });

    test('NMemMap addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test")..load();

      expect(() {
        memValue.addAll({
          'C': 'c',
          'D': 'd',
        });
      }, throwsA(isA<TypeError>()));
    });

    test('NMemMap remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test", initValue: {'a': "A"})..load();
      memValue.remove('a');
      expect(memValue.value, {});
    });

    test('NMemMap clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemMap("test", initValue: {'a': "A"})..load();
      memValue.clear();
      expect(memValue.value, {});
    });
  });
}
