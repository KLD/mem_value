import 'dart:convert';

import '../core/mem_value.dart';
import 'n_mem_iterable.dart';

/// A  nullable [MemValue] implementation for [List<T>]
/// Uses [jsonEncode] and [jsonDecode] for serialization
class NMemList<T> extends NMemIterable<T, List<T>> {
  /// Creates a [NMemList] instance
  NMemList(super.tag,
      {super.initValue,
      super.ignoreReset,
      super.decodeElement,
      super.encodeElement});

  void add(T item) {
    value = [...value!, item];
  }

  void addAll(Iterable<T> items) {
    value = [...value!, ...items];
  }

  void remove(String item) {
    value = value!..remove(item);
  }

  void clear() {
    value = [];
  }
}
