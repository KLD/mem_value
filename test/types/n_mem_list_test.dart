import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  // ignore: avoid_init_to_null
  var defaultInitliazedValue = null;
  var valueA = const ['item1'];
  var valueB = const ['item2'];

  group("NMemList initlization", () {
    test('NMemList throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('NMemList initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test")..load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('NMemList initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('NMemList set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemList serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();
      expect(() => memValue.parse(memValue.stringify(memValue.value)),
          throwsA(isA<NoSuchMethodError>()));
    });

    test('NMemList serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemList serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemList reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('NMemList reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: valueA)..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("NMemList addtional methods", () {
    test('NMemList add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: [])..load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('NMemList add without initlizing', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();

      expect(() => memValue.add('item2'), throwsA(isA<TypeError>()));
    });

    test('NMemList addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test")..load();

      expect(
          () => memValue.addAll(['item1', 'item2']), throwsA(isA<TypeError>()));
    });

    test('NMemList remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: ['item1'])..load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('NMemList clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: ['item1'])..load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
