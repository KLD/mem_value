import 'dart:convert';

import '../core/mem_value.dart';

/// Uses jsonEncode and jsonDecode to store and retrieve a Map of items.
class NMemMap<K, V> extends MemValue<Map<K, V>?> {
  NMemMap(super.tag, {super.initValue, super.persist});

  @override
  Map<K, V>? parse(String value) => jsonDecode(value).cast<K, V>();

  @override
  String stringify(Map<K, V>? value) => jsonEncode(value);

  void add(K k, V v) {
    value = {k: v, ...value!};
  }

  void addAll(Map<K, V> items) {
    value = {...value!, ...items};
  }

  void remove(K item) {
    value = value!..remove(item);
  }

  void clear() {
    value = {};
  }
}
