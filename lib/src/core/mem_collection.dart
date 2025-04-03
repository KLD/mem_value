import 'package:mem_value/mem_value.dart';

/// A collection of [MemValue]s.
class MemGroup {
  /// The [MemValue]s in the collection.
  final List<MemValue> _mems;

  /// Creates a [MemGroup] instance.
  MemGroup(this._mems);

  /// Loads all [MemValue]s in the collection.
  Future<void> loadAll() => Future.wait(_mems.map((e) => e.load()));

  /// Resets all [MemValue]s in the collection.
  Future<void> resetAll() => Future.wait(_mems.map((e) => e.reset()));

  /// Deletes all [MemValue]s in the collection.
  Future<void> deleteAll() => Future.wait(_mems.map((e) => e.delete()));
}
