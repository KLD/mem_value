/// Define a storage interface for storing data in memory.
abstract class MemStorage {
  const MemStorage();

  /// Reads value from storage. Null when value is not found.
  Future<String?> read(String tag);

  /// Writes value to storage.
  Future<void> write(String tag, String value);

  /// Deletes value from storage.
  Future<void> delete(String tag);
}
