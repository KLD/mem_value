import 'dart:convert';

import '../core/mem_value.dart';

/// Uses jsonEncode and jsonDecode to store and retrieve a Set of items.
class MemSet<T> extends MemValue<Set<T>> {
  MemSet(super.tag, {super.initValue = const {}, super.persist});

  @override
  Set<T> parse(String value) => Set.from(jsonDecode(value)).cast<T>();

  @override
  String stringify(Set<T> value) => jsonEncode(value.toList());

  void add(T item) {
    value = {...value, item};
  }

  void addAll(Iterable<T> items) {
    value = {...value, ...items};
  }

  void remove(String item) {
    value = value..remove(item);
  }

  void clear() {
    value = {};
  }
}
