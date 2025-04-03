import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  // ignore: avoid_init_to_null
  var defaultInitliazedValue = null;
  var valueA = const ['item1'];
  var valueB = const ['item2'];

  group("NMemList initlization", () {
    test('NMemList throw error when used without loading', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test");

      expect(() => memValue.value, throwsA(isA<MemValueException>()));
    });
    test('NMemList initlize with default value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test");
      await memValue.load();

      expect(memValue.value, defaultInitliazedValue);
    });

    test('NMemList initlize with initValue passed', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test", initValue: valueA);
      await memValue.load();
      expect(memValue.value, valueA);
    });

    test('NMemList set value', () async {
      MemValue.setStorage(createFakeStorage());

      var memValue = NMemList<String>("test");
      await memValue.load();
      memValue.value = valueA;
      expect(memValue.value, valueA);
    });

    test('NMemList parse empty list', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      var value = memValue.parse("[]");

      expect(value.length, 0, reason: 'expected empty list');
    });
    test('NMemList serilize and deserialize an assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      await memValue.load();
      memValue.value = valueA;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value, value);
    });

    test('NMemList serilize and deserialize another assigned value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      await memValue.load();
      memValue.value = valueB;
      var value = memValue.parse(memValue.stringify(memValue.value!));
      expect(memValue.value, value);
    });

    test('NMemList reset', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      await memValue.load();
      memValue.reset();
      expect(memValue.value, defaultInitliazedValue);
    });

    test('NMemList reset to intial value', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: valueA);
      await memValue.load();
      memValue.reset();
      expect(memValue.value, valueA);
    });
  });

  group("NMemList addtional methods", () {
    test('NMemList add', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: []);
      await memValue.load();
      memValue.add('item2');
      expect(memValue.value, ['item2']);
    });

    test('NMemList add without initlizing', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      await memValue.load();

      expect(() => memValue.add('item2'), throwsA(isA<TypeError>()));
    });

    test('NMemList addAll', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test");
      await memValue.load();

      expect(
          () => memValue.addAll(['item1', 'item2']), throwsA(isA<TypeError>()));
    });

    test('NMemList remove item', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: ['item1']);
      await memValue.load();
      memValue.remove('item1');
      expect(memValue.value, []);
    });

    test('NMemList clear', () async {
      MemValue.setStorage(createFakeStorage());
      var memValue = NMemList<String>("test", initValue: ['item1']);
      await memValue.load();
      memValue.clear();
      expect(memValue.value, []);
    });
  });
}
