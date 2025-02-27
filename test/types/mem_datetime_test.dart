import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() async {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('MemDateTime throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDateTime("test", initValue: DateTime(2000, 1, 1));

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('MemDateTime initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDateTime("test", initValue: DateTime(2000, 1, 1));
    await memValue.load();

    expect(memValue.value, DateTime(2000, 1, 1));
  });

  test('MemDateTime set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemDateTime("test", initValue: DateTime(2000, 1, 1));
    await memValue.load();
    memValue.value = DateTime(2010, 1, 1);
    expect(memValue.value, DateTime(2010, 1, 1));
  });

  test('MemDateTime serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDateTime("test", initValue: DateTime(2000, 1, 1));
    await memValue.load();
    memValue.value = DateTime(2010, 1, 1);
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('MemDateTime resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemDateTime("test", initValue: DateTime(2000, 1, 1));
    await memValue.load();
    memValue.value = DateTime(2010, 1, 1);
    memValue.reset();
    expect(memValue.value, DateTime(2000, 1, 1));
  });
}
