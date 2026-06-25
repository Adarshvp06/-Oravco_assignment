import 'package:flutter/material.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeMode theme = ThemeMode.system;

  static ThemeData get light => _lightTheme;
  static ThemeData get dark => _darkTheme;

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.backgroundLight,

    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: AppColors.onPrimaryLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.onSurfaceLight,
      secondary: AppColors.textSecondaryLight,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: const Color(0xff8E8E8E),
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    textTheme: AppTextTheme.lightTextTheme,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFillLight,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: paddingLarge,
        vertical: paddingLarge,
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.inputHintLight,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),
  );

  // ==================== DARK THEME ====================
  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.backgroundDark,

    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      onPrimary: AppColors.onPrimaryDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      secondary: AppColors.textSecondaryDark,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: const Color(0xff8E8E8E),
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    textTheme: AppTextTheme.darkTextTheme,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFillDark,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: paddingLarge,
        vertical: paddingLarge,
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.inputHintDark,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),
  );
}
