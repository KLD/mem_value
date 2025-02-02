import 'package:mem_value/src/core/mem_storage.dart';

/// An implementation of MemStorage using functions as parameters.
class MemStorageDelegate extends MemStorage {
  final Future<String?> Function(String) readValue;
  final Future<void> Function(String, String) writeValue;
  final Future<void> Function(String) deleteValue;

  MemStorageDelegate({
    required this.readValue,
    required this.writeValue,
    required this.deleteValue,
  });

  @override
  Future<String?> read(String tag) => readValue(tag);
  @override
  Future<void> write(String tag, String value) => writeValue(tag, value);
  @override
  Future<void> delete(String tag) => deleteValue(tag);
}
