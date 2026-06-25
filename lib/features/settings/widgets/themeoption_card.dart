
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extension/theme_extension.dart';

class ThemeOptionCard extends StatelessWidget {
  final ThemeMode themeMode;
  final ThemeMode currentMode;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ThemeOptionCard({super.key, 
    required this.themeMode,
    required this.currentMode,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentMode == themeMode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: opacityLow)
                : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColors.primaryColor
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                size: 24.sp,
              ),
              gapSmall,
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? AppColors.primaryColor
                      : (isDark ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}