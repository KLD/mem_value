import 'dart:convert';

import 'package:mem_value/src/types/n_mem_iterable.dart';

import '../core/mem_value.dart';

/// A nullable [MemValue] implementation for [Set<T>].
class NMemSet<E> extends NMemIterable<E, Set<E>> {
  /// Creates a [NMemSet] instance
  NMemSet(super.tag,
      {super.initValue,
      super.ignoreReset,
      super.decodeElement,
      super.encodeElement});

  /// Parses string into a set. If [decodeElement] is provided, it is used to decode the element.
  @override
  Set<E> parse(String value) =>
      Set.from(jsonDecode(value).map(_parseElementValue).cast<E>());

  /// Stringifies the set. If [encodeElement] is provided, it is used to encode the element.
  @override
  String stringify(Set<E> value) =>
      jsonEncode(value.map(_stringifyElementValue).toList());

  /// Parses the element value.
  E _parseElementValue(dynamic value) {
    if (decodeElement != null) {
      return decodeElement!(value);
    }
    return value as E;
  }

  /// Stringifies the element value.
  String _stringifyElementValue(E value) {
    if (encodeElement != null) {
      return encodeElement!(value);
    }
    return value.toString();
  }

  /// Adds an item to the set
  void add(E item) {
    value = {...value!, item};
  }

  /// Adds all items to the set
  void addAll(Iterable<E> items) {
    value = {...value!, ...items};
  }

  /// Removes an item from the set
  void remove(String item) {
    value = value!..remove(item);
  }

  /// Clears set
  void clear() {
    value = {};
  }
}
