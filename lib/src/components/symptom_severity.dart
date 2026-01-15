import 'package:asthma_diary/src/theme/colors.dart';
import 'package:flutter/material.dart';

class SeveritySelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const SeveritySelector({super.key, 
    required this.value,
    required this.onChanged,
  });

  Color _colorFor(int level) {
    switch (level) {
      case 1: return AppColors.success;
      case 2: return AppColors.success.withOpacity(0.7);
      case 3: return AppColors.warning;
      case 4: return AppColors.danger.withOpacity(0.8);
      case 5: return AppColors.danger;
      default: return AppColors.border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (i) {
        final level = i + 1;
        final selected = value == level;

        return GestureDetector(
          onTap: () => onChanged(level),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: selected
                  ? _colorFor(level)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: _colorFor(level).withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
          ),
        );
      }),
    );
  }
}
