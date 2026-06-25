import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/exception/custom_exception.dart';
import 'package:oravco_assignment/core/widgets/common_botton.dart';

import '../constants/constants.dart';
import '../extension/theme_extension.dart';

class CommonErrorWidget extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;
  const CommonErrorWidget({super.key, required this.error, this.onRetry});

  IconData _getIcon(ExceptionType type) {
    switch (type) {
      case ExceptionType.network:
        return Icons.wifi_off_rounded;
      case ExceptionType.timeout:
        return Icons.timer_outlined;
      case ExceptionType.unauthorized:
        return Icons.lock_person_outlined;
      case ExceptionType.notFound:
        return Icons.search_off_rounded;
      case ExceptionType.validation:
        return Icons.error_outline_rounded;
      case ExceptionType.server:
        return Icons.dns_rounded;
      case ExceptionType.cancel:
        return Icons.cancel_outlined;
      default:
        return Icons.error_outline_rounded;
    }
  }

  String _getTitle(ExceptionType type) {
    switch (type) {
      case ExceptionType.network:
        return 'Network Error';
      case ExceptionType.timeout:
        return 'Connection Timeout';
      case ExceptionType.unauthorized:
        return 'Access Denied';
      case ExceptionType.notFound:
        return 'Not Found';
      case ExceptionType.validation:
        return 'Validation Error';
      case ExceptionType.server:
        return 'Server Error';
      case ExceptionType.cancel:
        return 'Request Cancelled';
      default:
        return 'Something Went Wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exception = CustomException.fromError(error);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(middlePadding),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: opacityLow),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getIcon(exception.type),
            size: 64.r,
            color: AppColors.primaryColor,
          ),
        ),
        gapXL,
        Text(
          _getTitle(exception.type),
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textSecondary,
          ),
        ),
        gapSmall,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingXL.w),
          child: Text(
            exception.message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.textSecondary,
            ),
          ),
        ),

        if (onRetry != null) ...[
          gapLarge,
          CommonButton(
            buttonLoading: false,
            text: 'Retry',
            onPressed: onRetry!,
          ),
        ],
      ],
    );
  }
}
