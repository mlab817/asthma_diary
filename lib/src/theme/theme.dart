import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/spacing.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.surface,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1, // shadow-sm
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        side: const BorderSide(
          color: Color(0xFFF3F4F6), // gray-100
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero, // let layout decide
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
