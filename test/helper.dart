import 'package:mem_value/src/core/mem_storage.dart';
import 'package:mem_value/src/core/mem_storage_delegate.dart';

MemStorage createFakeStorage() {
  return MemStorageDelegate(
    readValue: (_) async => null,
    writeValue: (_, __) async {},
    deleteValue: (_) async {},
  );
}
