import 'dart:convert';

import 'package:mem_value/mem_value.dart';

mixin MemIterable<E, T extends Iterable<E>> on MemValue<T> {
  /// Decodes an element from string
  E Function(String)? decodeElement;

  /// Encodes an element to string
  String Function(E)? encodeElement;

  /// Parses a string value into an [Iterable] and parses each element to type [E].
  Iterable<E> parseIterable(String value) {
    return (jsonDecode(value) as Iterable)
        .cast<String>()
        .map(_parseElementValue);
  }

  /// parses each element from string. Uses [decodeElement] if provided,
  /// otherwise casts the value to [E].
  E _parseElementValue(String value) {
    if (decodeElement != null) {
      return decodeElement!(value);
    }
    return value as E;
  }

  @override
  String stringify(Iterable<E> value) =>
      jsonEncode(value.map(_stringifyElementValue).toList());

  /// stringifies each element to string. Uses [encodeElement] if provided,
  /// otherwise calls [toString] on the value.
  dynamic _stringifyElementValue(E? value) {
    if (encodeElement != null && value != null) {
      return encodeElement!(value);
    }
    return value;
  }
}
