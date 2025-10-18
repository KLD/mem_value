import 'package:flutter/foundation.dart';
import 'package:mem_value/mem_value.dart';

/// A value that stores its value in local storage.
abstract class MemValue<V> {
  /// A set of all used tags. Used to ensure uniqueness.
  static final _ids = <String>{};

  /// Storage delegate used to read, write, and delete.
  static MemStorage _memStorage = const _ErrorMemStorage();

  /// Sets global storage used in MemValues implementations.
  static void setStorage(MemStorage memStorage) {
    MemValue._memStorage = memStorage;
  }

  /// Sets global storage delegate used in MemValues implementations.
  static void setStorageDelegate(
      {required Future<String?> Function(String) readValue,
      required Future<void> Function(String, String) writeValue,
      required Future<void> Function(String) deleteValue}) {
    MemValue._memStorage = MemStorageDelegate(
        readValue: readValue, writeValue: writeValue, deleteValue: deleteValue);
  }

  /// Tag used to indentity value in memory. Must be unique
  final String tag;

  /// Inital value
  final V initValue;

  /// If `true`, it will not reset the value when `reset()` is called.
  final bool ignoreReset;

  /// Synced value with storage
  @protected
  V _internalValue;

  /// Indicates if the value is loaded from storage
  bool _isLoaded;

  /// Creates a new [MemValue] instance
  MemValue(
    this.tag, {
    required this.initValue,
    this.ignoreReset = false,
  })  : _internalValue = initValue,
        _isLoaded = false {
    if (!_ids.add(tag)) throw MemValueException("Tag $tag is already in use");
  }

  /// Reads value. MemValue must be loaded.
  V get value {
    _ensureLoaded();

    return _internalValue;
  }

  /// Assigns and stores value
  set value(V value) {
    _ensureLoaded();
    setValue(value);
  }

  /// Awaitable version of `set value`
  Future<void> setValue(V value) {
    load();
    if (!_isNewValue(value)) {
      _internalValue = value;
      return save();
    }
    return Future.value();
  }

  /// Loads and returns the value
  Future<V> read() async {
    if (!_isLoaded) {
      await load();
    }

    return _internalValue;
  }

  /// Loads the value from storage. If `skipIfLoaded` is `true`, it will not load if already loaded.
  Future<void> load([bool skipIfLoaded = true]) async {
    if (_isLoaded && skipIfLoaded) return;
    _isLoaded = true;
    final storedValue = await _memStorage.read(tag);

    if (storedValue != null) {
      _internalValue = parse(storedValue);
    } else if (initValue != null) {
      await save();
    }
  }

  /// Saves the value to local storage
  Future<void> save() async {
    if (_internalValue == null) {
      await _memStorage.delete(tag);
      return;
    }
    await _memStorage.write(tag, stringify(_internalValue));
  }

  /// Resets value to `initValue`. If `ignoreReset` is `true`, it will not reset.
  Future<void> reset() async {
    if (ignoreReset) return;

    await setValue(initValue);
  }

  /// Deletes value from storage
  Future<void> delete() => _memStorage.delete(tag);

  /// Compares two values for equality. Used to skip saving if values are equal.
  bool _isNewValue(V other) {
    return _internalValue == other;
  }

  /// Ensures that the value is loaded before reading/writing. Refer to: `load()`
  void _ensureLoaded() {
    if (!_isLoaded) {
      throw MemValueException(
          "Attempted to read value of $tag before loading it. use `load()`");
    }
  }

  /// Parses the `value` from a string
  V parse(String value);

  /// Converts the `value` to a string
  String stringify(covariant V value);

  /// Clears all used tags. Used for testing.
  static void clearIds() {
    _ids.clear();
  }
}

/// Default storage used if no storage is set. Throws an error if used.
class _ErrorMemStorage extends MemStorage {
  /// Creates a new instance of [_ErrorMemStorage]
  const _ErrorMemStorage();

  @override
  Future<void> delete(String tag) {
    throw MemValueException("Storage not set. Use Use `MemValue.setStorage`");
  }

  @override
  Future<String?> read(String tag) {
    throw MemValueException("Storage not set. Use `MemValue.setStorage`");
  }

  @override
  Future<void> write(String tag, String value) {
    throw MemValueException("Storage not set. Use `MemValue.setStorage`");
  }
}
