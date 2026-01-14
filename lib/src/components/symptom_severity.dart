import 'package:asthma_diary/src/theme/colors.dart';
import 'package:flutter/material.dart';

class SymptomSeverity extends StatelessWidget {
  const SymptomSeverity({
    super.key,
    required this.severity,
    required this.onChanged,
  });

  final double severity;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.primary,
        thumbColor: AppColors.primary,
      ),
      child: Slider(
        min: 1,
        max: 5,
        divisions: 4,
        value: severity.toDouble(),
        onChanged: onChanged,
      ),
    );
  }
}
