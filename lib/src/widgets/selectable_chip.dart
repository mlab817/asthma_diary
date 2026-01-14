import 'package:asthma_diary/src/controllers/selection_controller.dart';
import 'package:flutter/material.dart';

class SelectableChip<T> extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.item,
    required this.label,
    required this.controller,
  });

  final T item;
  final String label;
  final SelectionController<T> controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<T>>(
      valueListenable: controller.selectedItems,
      builder: (context, selected, _) {
        final isSelected = selected.contains(item);

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => controller.toggle(item),
          child: Chip(
            label: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).chipTheme.backgroundColor,
          ),
        );
      },
    );
  }
}
