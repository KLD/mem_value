import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  test('NMemString throw error when used without loading', () {
    MemValue.setStorage(createFakeStorage());

    var mem = NMemString("test");

    expect(() => mem.value, throwsA(isA<MemValueError>()));
  });
  test('NMemString initlize', () {
    MemValue.setStorage(createFakeStorage());

    var mem = NMemString("test")..load();

    expect(mem.value, null);
  });
  test('NMemString initlize', () {
    MemValue.setStorage(createFakeStorage());

    var mem = NMemString("test", initValue: "init")..load();

    expect(mem.value, "init");
  });

  test('NMemString set value', () async {
    MemValue.setStorage(createFakeStorage());

    var mem = NMemString("test")..load();
    mem.value = "new";
    expect(mem.value, "new");
  });

  test('NMemString serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var mem = NMemString("test")..load();
    mem.value = "new";
    var value = mem.parse(mem.stringify(mem.value));
    expect(mem.value, value);
  });

  test('NMemString resets to default value', () {
    MemValue.setStorage(createFakeStorage());
    var mem = NMemString("test")..load();
    mem.value = "new";
    mem.reset();
    expect(mem.value, null);
  });

  test('NMemString resets to initValue', () {
    MemValue.setStorage(createFakeStorage());
    var mem = NMemString("test", initValue: "init")..load();
    mem.value = "new";
    mem.reset();
    expect(mem.value, "init");
  });
}
