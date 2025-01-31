import 'dart:convert';

import '../core/mem_value.dart';

/// Users jsonEncode and jsonDecode to store and retrieve a List of items.
class MemList<T> extends MemValue<List<T>> {
  MemList(super.tag, {super.initValue = const [], super.persist});

  @override
  List<T> parse(String value) => jsonDecode(value).cast<T>();

  @override
  String stringify(List<T> value) => jsonEncode(value);

  void add(T item) {
    value = [...value, item];
  }

  void addAll(Iterable<T> items) {
    value = [...value, ...items];
  }

  void remove(String item) {
    value = value..remove(item);
  }

  void clear() {
    value = [];
  }
}
