import 'package:flutter/material.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Color get textSecondary => colorScheme.secondary;
  Color get borderColor => theme.brightness == Brightness.light
      ? AppColors.borderLight
      : AppColors.borderDark;
}
