import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/radius_elevation.dart';
import 'package:asthma_diary/src/theme/spacing.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: AppElevation.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      ),
    ),
  );
}
