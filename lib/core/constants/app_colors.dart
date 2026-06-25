import 'package:flutter/material.dart';
import 'package:oravco_assignment/core/constants/constants.dart';

class AppColors {

  static const Color primaryColor = Color(0xFF6366F1);
  static const Color secondaryColor = Color(0xff581C87);
  static final Color fillColor = primaryColor.withValues(alpha: opacityLow);
  static final Color dividerColor = Colors.grey.shade300;

  // --- Light Theme Colors ---
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color surfaceLight = Colors.white;
  static const Color onPrimaryLight = Colors.white;
  static const Color onSurfaceLight = Colors.black;
  static final Color textSecondaryLight = Colors.black;
  static final Color inputFillLight = Colors.grey.shade50;
  static final Color inputHintLight = Colors.grey.shade400;
  static final Color borderLight = Colors.grey.shade200;

  // --- Dark Theme Colors ---
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color onPrimaryDark = Colors.black;
  static const Color onSurfaceDark = Colors.white;
  static final Color textSecondaryDark = Colors.white;
  static const Color inputFillDark = Color(0xFF1E1E1E);
  static final Color inputHintDark = Colors.grey.shade500;
  static final Color borderDark = Colors.grey.shade800;

  // --- Semantic / Common Colors ---
  static const Color error = Colors.redAccent;
  static final Color success = Colors.green.shade600;
  static final Color warning = Colors.amber.shade600;

  static Gradient linearGradient = LinearGradient(
    colors: [
      primaryColor,
      primaryColor.withValues(alpha: opacityLow),
    ],
  );
}
