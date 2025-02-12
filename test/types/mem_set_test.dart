import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  Set defaultInitliazedValue = const {};
  var valueA = const {'item1'};
  var valueB = const {'item2'};

  group("MemSet initlization", () {
    test('MemSet throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemSet<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('MemSet initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemSet<String>("test")..load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemSet initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemSet<String>("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('MemSet set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemSet<String>("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('MemSet serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemSet serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemSet serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });
  });

  group("MemSet addtional methods", () {
    test('MemSet add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('MemSet add two items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.add('item1');
      memValue.add('item2');
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemSet add three items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.add('item1');
      memValue.add('item2');
      memValue.add('item3');
      expect(memValue.value, ['item1', 'item2', 'item3']);
    });

    test('MemSet addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test")..load();
      memValue.addAll(['item1', 'item2']);
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemSet remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test", initValue: {'item1'})..load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('MemSet clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemSet<String>("test", initValue: {'item1'})..load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
