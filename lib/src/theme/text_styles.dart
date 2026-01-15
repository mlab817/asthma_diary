// text_styles.dart
import 'package:flutter/material.dart';

import 'package:asthma_diary/src/theme/colors.dart';

class AppTextStyles {
  static TextStyle headline = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.mutedText,
  );

  static TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
  );

  static TextStyle textSm = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}
