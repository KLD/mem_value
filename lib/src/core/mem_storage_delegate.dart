import 'package:mem_value/src/core/mem_storage.dart';

/// An implementation of MemStorage using functions as parameters.
class MemStorageDelegate extends MemStorage {
  /// Given a tag, read value from storage.
  final Future<String?> Function(String) readValue;

  /// Given a tag and a value, write value to storage.
  final Future<void> Function(String, String) writeValue;

  /// Given a tag, delete value from storage.
  final Future<void> Function(String) deleteValue;

  /// Creates a MemStorageDelegate instance.
  const MemStorageDelegate({
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
