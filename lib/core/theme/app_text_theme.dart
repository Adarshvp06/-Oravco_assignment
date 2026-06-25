import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';


/// Centralized TextTheme configurations utilizing ScreenUtil's (.sp) scalable
/// pixel helper to ensure modern, responsive typography on all device dimensions.
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get lightTextTheme => TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceLight,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceLight,
          letterSpacing: -0.5,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceLight,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryLight,
        ),
      );

  static TextTheme get darkTextTheme => TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceDark,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceDark,
          letterSpacing: -0.5,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurfaceDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceDark,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryDark,
        ),
      );
}
