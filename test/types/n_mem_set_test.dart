import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  var valueA = const {'item1'};
  var valueB = const {'item2'};

  group("NMemSet initlization", () {
    test('NMemSet throw error when used without loading', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemSet<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueError>()));
    });
    test('NMemSet initlize with default value', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemSet<String>("test")..load();

      expect(memValue.value, null);
    });

    test('NMemSet initlize with initValue passed', () {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemSet<String>("test", initValue: valueA)..load();
      expect(memValue.value, valueA);
    });

    test('NMemSet set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemSet<String>("test")..load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemSet stringify throw Null Type error', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();

      expect(() => memValue.parse(memValue.stringify(memValue.value)),
          throwsA(isA<TypeError>()));
    });

    test('NMemSet serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('NMemSet serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });
  });

  group("NMemSet addtional methods", () {
    test('NMemSet add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test", initValue: {})..load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('NMemSet add without null value throws error', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();

      expect(() => memValue.add('item2'), throwsA(isA<TypeError>()));
    });

    test('NMemSet add three items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test", initValue: {})..load();
      memValue.add('item1');
      memValue.add('item2');
      memValue.add('item3');
      expect(memValue.value, ['item1', 'item2', 'item3']);
    });

    test('NMemSet addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test", initValue: {})..load();
      memValue.addAll(['item1', 'item2']);
      expect(memValue.value, ['item1', 'item2']);
    });
    test('NMemSet addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();

      expect(
          () => memValue.addAll(['item1', 'item2']), throwsA(isA<TypeError>()));
    });

    test('NMemSet remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test")..load();

      expect(
        () => memValue.remove('item1'),
        throwsA(isA<TypeError>()),
      );
    });
    test('NMemSet remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test", initValue: {'item1'})..load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('NMemSet clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemSet<String>("test", initValue: {'item1'})..load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
