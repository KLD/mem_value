import 'dart:convert';

import 'package:mem_value/src/types/mem_iterable.dart';

import '../core/mem_value.dart';

/// A [MemValue] implementation for [Set].
/// Uses [jsonEncode] and [jsonDecode] for serialization.
/// Wraps set implementation and provides methods to interact with it.
class MemSet<E> extends MemValue<Set<E>>
    with MemIterable<E, Set<E>>
    implements Set<E> {
  /// Creates a new [MemSet] instance
  MemSet(
    super.tag, {
    super.initValue = const {},
    String Function(E)? encodeElement,
    E Function(String)? decodeElement,
  }) {
    this.encodeElement = encodeElement;
    this.decodeElement = decodeElement;
  }

  @override
  Set<E> parse(String value) => parseIterable(value).toSet();

  @override
  E get first => value.first;

  @override
  E get last => value.last;

  @override
  int get length => value.length;

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    save();
  }

  @override
  bool any(bool Function(E element) test) => value.any(test);

  @override
  void clear() {
    value.clear();
    save();
  }

  @override
  bool contains(Object? element) => value.contains(element);

  @override
  E elementAt(int index) => value.elementAt(index);

  @override
  bool every(bool Function(E element) test) => value.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) =>
      value.expand(toElements);

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      value.fold(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => value.followedBy(other);

  @override
  void forEach(void Function(E element) action) => value.forEach(action);

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  String join([String separator = ""]) => value.join(separator);

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.lastWhere(test, orElse: orElse);

  @override
  Iterable<T> map<T>(T Function(E e) toElement) => value.map(toElement);

  @override
  E reduce(E Function(E value, E element) combine) => value.reduce(combine);

  @override
  bool remove(Object? value) => this.value.remove(value);

  @override
  void removeWhere(bool Function(E element) test) => value.removeWhere(test);

  @override
  void retainWhere(bool Function(E element) test) => value.retainWhere(test);

  @override
  E get single => value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> skip(int count) => value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => value.skipWhile(test);

  @override
  Iterable<E> take(int count) => value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => value.toList(growable: growable);

  @override
  Set<E> toSet() => value.toSet();

  @override
  Iterable<E> where(bool Function(E element) test) => value.where(test);

  @override
  Iterable<T> whereType<T>() => value.whereType<T>();

  @override
  bool containsAll(Iterable<Object?> other) => value.containsAll(other);

  @override
  Set<E> difference(Set<Object?> other) => value.difference(other);

  @override
  Set<E> intersection(Set<Object?> other) => value.intersection(other);

  @override
  E? lookup(Object? object) => value.lookup(object);

  @override
  void removeAll(Iterable<Object?> elements) => value.removeAll(elements);

  @override
  void retainAll(Iterable<Object?> elements) => value.retainAll(elements);

  @override
  Set<E> union(Set<E> other) => value.union(other);

  @override
  bool add(E value) => this.value.add(value);

  @override
  Set<R> cast<R>() => value.cast<R>();
}
