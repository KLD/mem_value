import 'dart:convert';
import 'dart:math';

import 'package:mem_value/src/types/mem_iterable.dart';

import '../core/mem_value.dart';

/// A [MemValue] implementation for [List].
/// Uses [jsonEncode] and [jsonDecode] for serialization.
/// Wraps list implementation and provides methods to interact with it.
class MemList<E> extends MemValue<List<E>>
    with MemIterable<E, List<E>>
    implements List<E> {
  /// Creates a new [MemList] instance
  MemList(
    super.tag, {
    List<E>? initValue,
    String Function(E)? encodeElement,
    E Function(String)? decodeElement,
  }) : super(initValue: initValue ?? []) {
    this.encodeElement = encodeElement;
    this.decodeElement = decodeElement;
  }

  @override
  List<E> parse(String value) => parseIterable(value).toList();

  @override
  E get first => value.first;

  @override
  set first(E value) {
    this.value.first = value;
    save();
  }

  @override
  E get last => value.last;

  @override
  set last(E value) {
    this.value.last = value;
    save();
  }

  @override
  int get length => value.length;

  @override
  set length(int value) {
    this.value.length = value;
    save();
  }

  @override
  List<E> operator +(List<E> other) => value + other;

  @override
  E operator [](int index) => value[index];

  @override
  void operator []=(int index, E value) {
    this.value[index] = value;
    save();
  }

  @override
  void add(E value) {
    this.value.add(value);
    save();
  }

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    save();
  }

  @override
  bool any(bool Function(E element) test) => value.any(test);

  @override
  Map<int, E> asMap() => value.asMap();

  @override
  List<R> cast<R>() => value.cast<R>();

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
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    save();
  }

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
  Iterable<E> getRange(int start, int end) => value.getRange(start, end);

  @override
  int indexOf(E element, [int start = 0]) => value.indexOf(element, start);

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      value.indexWhere(test, start);

  @override
  void insert(int index, E element) => value.insert(index, element);

  @override
  void insertAll(int index, Iterable<E> iterable) =>
      value.insertAll(index, iterable);

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  String join([String separator = ""]) => value.join(separator);

  @override
  int lastIndexOf(E element, [int? start]) => value.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      value.lastIndexWhere(test, start);

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
  E removeAt(int index) => value.removeAt(index);

  @override
  E removeLast() => value.removeLast();

  @override
  void removeRange(int start, int end) => value.removeRange(start, end);

  @override
  void removeWhere(bool Function(E element) test) => value.removeWhere(test);

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) =>
      value.replaceRange(start, end, replacements);

  @override
  void retainWhere(bool Function(E element) test) => value.retainWhere(test);

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) => value.setAll(index, iterable);

  @override
  void setRange(int start, int end, Iterable<E> iterable,
          [int skipCount = 0]) =>
      value.setRange(start, end, iterable, skipCount);

  @override
  void shuffle([Random? random]) => value.shuffle(random);

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
  void sort([int Function(E a, E b)? compare]) => value.sort(compare);

  @override
  List<E> sublist(int start, [int? end]) => value.sublist(start, end);

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
}
