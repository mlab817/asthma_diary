import 'package:flutter/material.dart';

class SelectionController<T> {
  final ValueNotifier<Set<T>> _selectedItems = ValueNotifier<Set<T>>(<T>{});

  ValueNotifier<Set<T>> get selectedItems => _selectedItems;

  bool get isEmpty => _selectedItems.value.isEmpty;

  void toggle(T item) {
    final current = _selectedItems.value;
    final next = Set<T>.from(current);

    if (next.contains(item)) {
      next.remove(item);
    } else {
      next.add(item);
    }

    _selectedItems.value = next;
  }

  void clear() {
    _selectedItems.value = <T>{};
  }

  bool isSelected(T item) {
    return _selectedItems.value.contains(item);
  }

  void dispose() {
    _selectedItems.dispose();
  }
}
