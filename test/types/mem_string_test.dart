import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('MemString throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemString("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('MemString initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemString("test");
    await memValue.load();

    expect(memValue.value, "");
  });
  test('MemString initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemString("test", initValue: "init");
    await memValue.load();

    expect(memValue.value, "init");
  });

  test('MemString set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = MemString("test");
    await memValue.load();
    memValue.value = "new";
    expect(memValue.value, "new");
  });

  test('MemString serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemString("test");
    await memValue.load();
    memValue.value = "new";
    var value = memValue.parse(memValue.stringify(memValue.value));
    expect(memValue.value, value);
  });

  test('MemString resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemString("test");
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, "");
  });

  test('MemString resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = MemString("test", initValue: "init");
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, "init");
  });
}
