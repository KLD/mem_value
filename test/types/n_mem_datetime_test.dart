import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('NMemDateTime throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDateTime("test", initValue: DateTime(2000, 1, 1));

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('NMemDateTime defaults to null', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDateTime(
      "test",
    )..load();

    expect(memInt.value, null);
  });
  test('NMemDateTime initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDateTime("test", initValue: DateTime(2000, 1, 1))..load();

    expect(memInt.value, DateTime(2000, 1, 1));
  });

  test('NMemDateTime set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = NMemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    expect(memInt.value, DateTime(2010, 1, 1));
  });

  test('NMemDateTime serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('NMemDateTime resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDateTime("test", initValue: DateTime(2000, 1, 1))..load();
    memInt.value = DateTime(2010, 1, 1);
    memInt.reset();
    expect(memInt.value, DateTime(2000, 1, 1));
  });

  test('NMemDateTime resets to null', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = NMemDateTime("test")..load();
    memInt.value = DateTime(2010, 1, 1);
    memInt.reset();
    expect(memInt.value, null);
  });
}
