import 'package:mem_value/mem_value.dart';

/// A collection of [MemValue]s.
class MemCollection {
  final List<MemValue> _mems;

  MemCollection(this._mems);

  /// Loads all [MemValue]s in the collection.
  Future<void> loadAll() => Future.wait(_mems.map((e) => e.load()));

  /// Resets all [MemValue]s in the collection.
  Future<void> resetAll() => Future.wait(_mems.map((e) => e.reset()));

  /// Deletes all [MemValue]s in the collection.
  Future<void> deleteAll() => Future.wait(_mems.map((e) => e.delete()));
}
