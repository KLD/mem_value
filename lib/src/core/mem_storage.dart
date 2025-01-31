abstract class MemStorage {
  const MemStorage();

  Future<String?> read(String tag);
  Future<void> write(String tag, String value);
  Future<void> delete(String tag);
}
