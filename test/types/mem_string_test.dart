import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('MemString throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemString("test");

    expect(() => memInt.value, throwsA(isA<MemValueError>()));
  });
  test('MemString initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemString("test")..load();

    expect(memInt.value, "");
  });
  test('MemString initlize', () {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemString("test", initValue: "init")..load();

    expect(memInt.value, "init");
  });

  test('MemString set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memInt = MemString("test")..load();
    memInt.value = "new";
    expect(memInt.value, "new");
  });

  test('MemString serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemString("test")..load();
    memInt.value = "new";
    var value = memInt.parse(memInt.stringify(memInt.value));
    expect(memInt.value, value);
  });

  test('MemString resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemString("test")..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, "");
  });

  test('MemString resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var memInt = MemString("test", initValue: "init")..load();
    memInt.value = "new";
    memInt.reset();
    expect(memInt.value, "init");
  });
}
