import 'package:flutter/material.dart';

class SelectionController<T> {
  final ValueNotifier<Set<T>> selectedItems = ValueNotifier({});
  final ValueNotifier<Map<T, int>> severityMap = ValueNotifier({}); // severity 1-5

  void toggle(T item) {
    final current = Set<T>.from(selectedItems.value);
    if (current.contains(item)) {
      current.remove(item);
      severityMap.value = Map<T, int>.from(severityMap.value)..remove(item);
    } else {
      current.add(item);
      severityMap.value = Map<T, int>.from(severityMap.value)..[item] = 3; // default severity
    }
    selectedItems.value = current;
  }

  void setSeverity(T item, int severity) {
    if (selectedItems.value.contains(item)) {
      severityMap.value = Map<T, int>.from(severityMap.value)..[item] = severity;
    }
  }

  void dispose() {
    selectedItems.dispose();
    severityMap.dispose();
  }
}
