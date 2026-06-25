import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';

import '../constants/app_colors.dart';
import '../constants/constants.dart';

enum ButtonType {
  filled,
  outlined;

  Color get color {
    return switch (this) {
      ButtonType.filled => AppColors.primaryColor,
      ButtonType.outlined => Colors.transparent,
    };
  }

  BoxBorder? border(BuildContext context, Color? customBorderColor) {
    return switch (this) {
      ButtonType.filled => null,
      ButtonType.outlined => Border.all(
        color: customBorderColor ?? context.borderColor,
      ),
    };
  }

  Gradient get gradient => AppColors.linearGradient;
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    this.aspectRatio = 317 / 47,
    this.icon,
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor,
    this.backgroundColor,
    this.buttonType = ButtonType.filled,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: paddingLarge),
    this.fontSize,
    this.borderRadius,
    this.gradient,
    this.fontWeight,
    this.textStyle,
    this.customBorderColor,
  });

  final bool buttonLoading;
  final Color? textColor;
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final Color? backgroundColor;
  final bool expanded;
  final Widget? icon;
  final ButtonType buttonType;
  final double aspectRatio;
  final double? fontSize;
  final double? borderRadius;
  final Gradient? gradient;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final Color? customBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Widget button = Builder(
      builder: (context) {
        final buttonChild = AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              border: buttonType.border(context, customBorderColor),
              gradient: backgroundColor == null
                  ? gradient ?? buttonType.gradient
                  : null,
              borderRadius: BorderRadius.circular(
                borderRadius ?? defaultBorderRadius,
              ),
              color: backgroundColor ?? buttonType.color,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  borderRadius ?? defaultBorderRadius,
                ),
                onTap: (buttonLoading || !enabled)
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        HapticFeedback.lightImpact();
                        onPressed();
                      },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Builder(
                    builder: (context) {
                      if (buttonLoading) {
                        return SizedBox(
                          height: 20.w,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: textColor ?? context.textSecondary,
                          ),
                        );
                      }

                      final textWidget = Text(
                        text,
                        style:
                            textStyle ??
                            theme.textTheme.bodyMedium?.copyWith(
                              fontSize: fontSize ?? 16.sp,
                              fontWeight: fontWeight ?? FontWeight.w600,
                              color: textColor ?? context.textSecondary,
                            ),
                      );

                      if (icon != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [icon!, gap, textWidget],
                        );
                      }
                      return textWidget;
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        return buttonChild;
      },
    );

    if (expanded) {
      return Row(children: [Expanded(child: button)]);
    } else {
      return button;
    }
  }
}
