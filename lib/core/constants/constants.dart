import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'app_colors.dart';

const double padding = 8;
const double paddingLarge = 16;
const double middlePadding = 25;
const double paddingXL = 32;
const double paddingXXL = 64;
const double paddingSmall = 4;
const double paddingTiny = 2;

const gap = Gap(padding);
const gapLarge = Gap(paddingLarge);
const gapXL = Gap(paddingXL);
const gapXXL = Gap(paddingXXL);
const gapSmall = Gap(paddingSmall);
const gapTiny = Gap(paddingTiny);

const double defaultBorderRadius = 12;
const double largeBorderRadius = 24;

List<BoxShadow> appShadow = [
  BoxShadow(
    color: AppColors.primaryColor.withValues(alpha: 0.3),
    blurRadius: 15,
    offset: Offset(0, 6),
  ),
];

const double opacityLow = 0.1;
const double opacityMedium = 0.2;
const double opacityStrong = 0.6;
const double opacityHigh = 0.8;

const Duration splashScreenDelay = Duration(seconds: 2);
const Duration loginDelay = Duration(milliseconds: 1500);

