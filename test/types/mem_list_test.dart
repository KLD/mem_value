import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  var defaultInitliazedValue = const [];
  var valueA = const ['item1'];
  var valueB = const ['item2'];

  group("MemList initlization", () {
    test('MemList throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('MemList initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test")..load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemList initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('MemList set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('MemList serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemList serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemList serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemList reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemList reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: valueA)..load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("MemList addtional methods", () {
    test('MemList add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('MemList add two items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.add('item1');
      memValue.add('item2');
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemList add three items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.add('item1');
      memValue.add('item2');
      memValue.add('item3');
      expect(memValue.value, ['item1', 'item2', 'item3']);
    });

    test('MemList addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test")..load();
      memValue.addAll(['item1', 'item2']);
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemList remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: ['item1'])..load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('MemList clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: ['item1'])..load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
