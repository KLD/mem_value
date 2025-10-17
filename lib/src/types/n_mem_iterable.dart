import 'dart:convert';

import 'package:mem_value/mem_value.dart';

/// A nullable [MemValue] implementation for [Iterable]
abstract class NMemIterable<E, T extends Iterable<E>> extends MemValue<T?> {
  /// Decodes an element from string
  final E Function(dynamic)? decodeElement;

  /// Encodes an element to string
  final String Function(E)? encodeElement;

  /// Creates a [NMemIterable] instance
  NMemIterable(super.tag,
      {required super.initValue,
      super.ignoreReset,
      this.decodeElement,
      this.encodeElement});

  @override
  T parse(String value) => (jsonDecode(value) as Iterable)
      .cast<String>()
      .map(_parseElementValue)
      .cast<E>()
      .toList() as T;

  @override
  String stringify(T value) =>
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
}
