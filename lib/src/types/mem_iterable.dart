import 'dart:convert';

import 'package:mem_value/mem_value.dart';

mixin MemIterable<E, T extends Iterable<E>> on MemValue<T> {
  /// Decodes an element from string
  E Function(String)? decodeElement;

  /// Encodes an element to string
  String Function(E)? encodeElement;

  Iterable<E> parseIterable(String value) {
    return (jsonDecode(value) as Iterable)
        .cast<String>()
        .map(_parseElementValue);
  }

  @override
  String stringify(Iterable<E> value) =>
      jsonEncode(value.map(_stringifyElementValue).toList());

  /// parses each element from string
  E _parseElementValue(String value) {
    if (decodeElement != null) {
      return decodeElement!(value);
    }
    return value as E;
  }

  /// stringifies each element to string
  String _stringifyElementValue(E? value) {
    if (encodeElement != null && value != null) {
      return encodeElement!(value);
    }
    return value.toString();
  }

  @override
  bool isEqual(Iterable<E?> other) {
    if (value.length != other.length) {
      return false;
    }

    for (var i = 0; i < value.length; i++) {
      if (value.elementAt(i) != other.elementAt(i)) {
        return false;
      }
    }

    return true;
  }
}
