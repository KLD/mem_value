import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });
  test("Mem Value error when storage is not assigned", () {
    var memValue = MemInt("int");

    expect(() => memValue.value, throwsA(isA<MemValueException>()),
        reason: 'throws error MemValue.setStorage not setup');
  });

  test("MemValue call 'read' once with value is loaded", () async {
    int readIsCallCount = 0;
    // int writeIsCallCount = 0;
    // int deleteIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(readValue: (_) async {
      readIsCallCount++;
      return null;
    }, writeValue: (_, __) async {
      // writeIsCallCount++;
    }, deleteValue: (_) async {
      // deleteIsCallCount++;
    }));

    var memValue = MemInt("int");

    await memValue.load();

    expect(readIsCallCount, 1, reason: 'read is called once');
  });
  test("MemValue.load calls `write` once with value is loaded", () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = MemInt("int");

    await memValue.load();

    expect(writeIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue.load doesn't call 'write' with initial value is null",
      () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int");

    await memValue.load();

    expect(writeIsCallCount, 0, reason: 'write is called once');
  });

  test("MemValue.load calls 'read' and parses stored value", () async {
    int readIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async {
          readIsCallCount++;
          return "1";
        },
        writeValue: (_, __) async {},
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int");

    await memValue.load();

    expect(readIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue calls `write` once when assigns a new value", () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int");
    await memValue.load();
    memValue.value = 1;

    expect(writeIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue calls `write` once when initlizing a new value", () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int", initValue: 1);
    await memValue.load();

    expect(writeIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue doesn't call `write` when assigning same value", () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int");
    await memValue.load();
    memValue.value = 1;
    memValue.value = 1;

    expect(writeIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue call `write` twice when assigning two different values",
      () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = NMemInt("int");
    await memValue.load();
    memValue.value = 1;
    memValue.value = 2;

    expect(writeIsCallCount, 2, reason: 'write is called once');
  });

  test("MemValue load called 'write` when loading", () async {
    int writeIsCallCount = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => writeIsCallCount++,
        deleteValue: (_) async => Future.value()));

    var memValue = MemInt("int");
    await memValue.load();

    expect(writeIsCallCount, 1, reason: 'write is called once');
  });

  test("MemValue calls `delete` when assigning null", () async {
    int count = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => Future.value(),
        deleteValue: (_) async => count++));

    var memValue = NMemInt("int");
    await memValue.load();
    memValue.value = 1;
    memValue.value = null;

    expect(count, 1, reason: 'delete is called once');
  });

  test("MemValue calls `delete` when resetting nullable MemValue", () async {
    int count = 0;

    MemValue.setStorage(MemStorageDelegate(
        readValue: (_) async => null,
        writeValue: (_, __) async => Future.value(),
        deleteValue: (_) async => count++));

    var memValue = NMemInt("int");
    await memValue.load();
    memValue.value = 1;
    memValue.reset();

    expect(count, 1, reason: 'delete is called once');
  });
}
