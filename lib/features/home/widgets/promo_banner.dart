import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summer Sale!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                  ),
                ),
                const Gap(4),
                Text(
                  'Get up to 50% off on premium store products.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13.sp,
                  ),
                ),
                gapLarge,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingLarge,
                      vertical: paddingSmall,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                  child: Text(
                    'Shop Now',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          gapLarge,
          Icon(
            Icons.shopping_bag_outlined,
            size: 80.w,
            color: Colors.white.withValues(alpha: opacityMedium),
          ),
        ],
      ),
    );
  }
}
