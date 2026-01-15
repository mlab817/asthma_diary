import 'package:asthma_diary/src/theme/button_depth.dart';
import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton3D extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  const PrimaryButton3D({super.key, 
    required this.label,
    required this.onPressed,
    this.color = AppColors.primary,
  });

  @override
  State<PrimaryButton3D> createState() => _PrimaryButton3DState();
}

class _PrimaryButton3DState extends State<PrimaryButton3D> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _pressed ? 2 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: enabled ? widget.color : AppColors.border,
          borderRadius: BorderRadius.circular(14),
          boxShadow: enabled
              ? (_pressed ? ButtonDepth.pressed as List<BoxShadow>? : ButtonDepth.raised as List<BoxShadow>?)
              : ButtonDepth.disabled as List<BoxShadow>?,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Center(
          child: Text(
            widget.label,
            style: AppTextStyles.button.copyWith(
              color: enabled
                  ? AppColors.onPrimary
                  : AppColors.mutedText,
            ),
          ),
        ),
      ),
    );
  }
}
