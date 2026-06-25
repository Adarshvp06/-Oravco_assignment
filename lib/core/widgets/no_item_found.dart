import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/core/widgets/common_botton.dart';
import '../constants/constants.dart';

class NoItemFound extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool showPullDownRefresh;
  final String? buttonText;
  final VoidCallback? onPressed;

  const NoItemFound({
    super.key,
    this.title = 'No Items Found',
    this.message = 'It looks like there is nothing here yet.',
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.showPullDownRefresh = false,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final fallbackIconColor = AppColors.primaryColor;
    final fallbackBgColor = AppColors.primaryColor.withValues(alpha: opacityLow);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(paddingLarge),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? fallbackBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64.sp,
                  color: iconColor ?? fallbackIconColor,
                ),
              ),
              gapXL,
            ],
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            gapSmall,
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.brightness == Brightness.light
                    ? Colors.grey.shade600
                    : Colors.grey.shade400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onPressed != null) ...[
              gapXL,
              CommonButton(
                buttonLoading: false,
                text: buttonText!,
                onPressed: onPressed!,
              ),
            ],
            if (showPullDownRefresh) ...[
              gapLarge,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.primaryColor.withValues(alpha: opacityLow),
                  ),
                  gapSmall,
                  Text(
                    "Pull down to refresh",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor.withValues(alpha: opacityMedium),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
