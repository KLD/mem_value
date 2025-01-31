import 'package:flutter/foundation.dart';

import '../error/mem_value_error.dart';
import 'mem_storage.dart';

/// A value that stores its value in local storage.
abstract class MemValue<V> {
  /// Storage delegate used to read, write, and delete.
  static MemStorage _memStorage = const _ErrorMemStorage();

  static void setStorage(MemStorage memStorage) {
    MemValue._memStorage = memStorage;
  }

  /// Tag used to indentity value in memory. Must be unique
  final String tag;

  /// Inital value
  final V initValue;

  /// Prevents resetting value
  final bool persist;

  @protected

  /// Synced value with storage
  V _internalValue;

  bool _isLoaded;

  /// Creates a new [MemValue] instance
  MemValue(
    this.tag, {
    required this.initValue,
    this.persist = false,
  })  : _internalValue = initValue,
        _isLoaded = false;

  /// Reads value
  V get value {
    _ensureLoaded();
    return _internalValue;
  }

  /// Assigns and stores value from
  set value(V value) => setValue(value);

  /// Awaitable version of `set value`
  Future<void> setValue(V value) {
    _ensureLoaded();
    if (value != _internalValue) {
      _internalValue = value;
      return save();
    }
    return Future.value();
  }

  /// Loads the value using storage delegate
  Future<void> load() async {
    _isLoaded = true;
    final storedValue = await _memStorage.read(tag);
    if (storedValue == null) {
      _internalValue = initValue;
    } else {
      _internalValue = parse(storedValue);
    }

    if (_internalValue != null) {
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

  /// Resets value to `initValue`. Deletes value if `initValue` equals `null`.
  Future<void> reset() async {
    if (persist) return;

    value = initValue;
  }

  Future<void> deleteTag() => _memStorage.delete(tag);

  /// Ensures that the value is loaded before reading/writing. Refer to: `load()`
  void _ensureLoaded() {
    if (!_isLoaded) {
      throw MemValueError(
          "Attempted to read value of $tag before loading it. use `load()`");
    }
  }

  /// Parses the `value` from a string
  V parse(String value);

  /// Converts the `value` to a string
  String stringify(V value);
}

class _ErrorMemStorage extends MemStorage {
  const _ErrorMemStorage();
  @override
  Future<void> delete(String tag) {
    throw MemValueError("Storage not set. Use Use `MemValue.setStorage`");
  }

  @override
  Future<String?> read(String tag) {
    throw MemValueError("Storage not set. Use `MemValue.setStorage`");
  }

  @override
  Future<void> write(String tag, String value) {
    throw MemValueError("Storage not set. Use `MemValue.setStorage`");
  }
}
