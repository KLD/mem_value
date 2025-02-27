import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });

  test('NMemString throw error when used without loading', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemString("test");

    expect(() => memValue.value, throwsA(isA<MemValueException>()));
  });
  test('NMemString initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemString("test");
    await memValue.load();

    expect(memValue.value, null);
  });
  test('NMemString initlize', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemString("test", initValue: "init");
    await memValue.load();

    expect(memValue.value, "init");
  });

  test('NMemString set value', () async {
    MemValue.setStorage(createFakeStorage());

    var memValue = NMemString("test");
    await memValue.load();
    memValue.value = "new";
    expect(memValue.value, "new");
  });

  test('NMemString serilize and deserialize works', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemString("test");
    await memValue.load();
    memValue.value = "new";
    var value = memValue.parse(memValue.stringify(memValue.value!));
    expect(memValue.value, value);
  });

  test('NMemString resets to default value', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemString("test");
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, null);
  });

  test('NMemString resets to initValue', () async {
    MemValue.setStorage(createFakeStorage());
    var memValue = NMemString("test", initValue: "init");
    await memValue.load();
    memValue.value = "new";
    memValue.reset();
    expect(memValue.value, "init");
  });
}
