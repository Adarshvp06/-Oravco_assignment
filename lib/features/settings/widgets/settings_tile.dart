
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extension/theme_extension.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({super.key, 
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: opacityLow),
            borderRadius: BorderRadius.circular(defaultBorderRadius - 4),
          ),
          child: Icon(icon, color: AppColors.primaryColor),
        ),
        title: Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16.sp,
          color: isDark ? Colors.grey[500] : Colors.grey[400],
        ),
      ),
    );
  }
}

