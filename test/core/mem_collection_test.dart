import 'package:flutter_test/flutter_test.dart';
import 'package:mem_value/mem_value.dart';

import '../helper.dart';

void main() {
  group('MemCollection', () {
    late MemInt memValue1;
    late MemInt memValue2;
    late MemCollection memCollection;

    setUp(() {
      MemValue.setStorage(createFakeStorage());
      memValue1 = MemInt('a');
      memValue2 = MemInt('b');
      memCollection = MemCollection([memValue1, memValue2]);
    });

    test('loadAll calls load on all MemValues', () async {
      await memCollection.loadAll();

      expect(() => memValue1.value, returnsNormally);
      expect(() => memValue2.value, returnsNormally);
    });

    test('resetAll calls reset on all MemValues', () async {
      await memCollection.loadAll();

      memValue1.value = 10;
      memValue2.value = 20;
      await memCollection.resetAll();

      expect(memValue1.value, 0);
      expect(memValue2.value, 0);
    });
  });
}
