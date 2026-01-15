import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // w-full
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.95 : 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // bg-blue-600
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16), // py-4
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // rounded-xl
              ),
            ),
            child: Text(
              widget.label,
              style: AppTextStyles.button.copyWith(
                fontWeight: FontWeight.w600, // font-semibold
                color: Colors.white, // text-white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
