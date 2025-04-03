import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() async {
  tearDown(() async {
    MemValue.clearIds();
  });

  var defaultInitliazedValue = const [];
  var valueA = const ['item1'];
  var valueB = const ['item2'];

  group("MemList initlization", () {
    test('MemList throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('MemList initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test");
      await memValue.load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemList initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('MemList set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('MemList serilize value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      var value = memValue.stringify(memValue.value);
      expect(value, '[]');
    });

    test('MemList serilize and deserialize default value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.isEqual(value), true);
    });

    test('MemList serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemList serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value));
      expect(memValue.value, value);
    });

    test('MemList reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('MemList reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: valueA);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("MemList addtional methods", () {
    test('MemList add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('MemList add two items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.add('item1');
      memValue.add('item2');
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemList add three items', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.add('item1');
      memValue.add('item2');
      memValue.add('item3');
      expect(memValue.value, ['item1', 'item2', 'item3']);
    });

    test('MemList addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test");
      await memValue.load();
      memValue.addAll(['item1', 'item2']);
      expect(memValue.value, ['item1', 'item2']);
    });

    test('MemList remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: ['item1']);
      await memValue.load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('MemList clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = MemList<String>("test", initValue: ['item1']);
      await memValue.load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
