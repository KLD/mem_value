import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  tearDown(() async {
    MemValue.clearIds();
  });
  group('MemGroup', () {
    late MemInt memValue1;
    late MemInt memValue2;
    late MemGroup memGroup;

    setUp(() {
      MemValue.setStorage(createFakeStorage());
      memValue1 = MemInt('a');
      memValue2 = MemInt('b');
      memGroup = MemGroup([memValue1, memValue2]);
    });

    test('loadAll calls load on all MemValues', () async {
      await memGroup.loadAll();

      expect(() => memValue1.value, returnsNormally);
      expect(() => memValue2.value, returnsNormally);
    });

    test('resetAll calls reset on all MemValues', () async {
      await memGroup.loadAll();

      memValue1.value = 10;
      memValue2.value = 20;
      await memGroup.resetAll();

      expect(memValue1.value, 0);
      expect(memValue2.value, 0);
    });
  });
}
