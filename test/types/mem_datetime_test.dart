import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('MemDateTime throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDateTime("test", initValue: DateTime(2000, 1, 1));

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('MemDateTime initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDateTime("test", initValue: DateTime(2000, 1, 1))..load();

    expect(memInt.value, DateTime(2000, 1, 1));
  });

  test('MemDateTime set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    expect(memInt.value, DateTime(2010, 1, 1));
  });

  test('MemDateTime serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('MemDateTime resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    memInt.reset();
    expect(memInt.value, DateTime(2000, 1, 1));
  });
}
