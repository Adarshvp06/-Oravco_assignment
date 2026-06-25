import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';

class ProductListingShimmer extends StatelessWidget {
  const ProductListingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chips skeleton
        SizedBox(
          height: 38.w,
          child: CommonShimmer(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: padding),
                  child: Container(
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        gapLarge,
        // Product list skeleton
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Banner skeleton
              CommonShimmer(
                child: Container(
                  height: 120.w,
                  margin: const EdgeInsets.symmetric(horizontal: paddingLarge),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(largeBorderRadius),
                  ),
                ),
              ),
              gapLarge,
              // Grouped skeleton items
              ...List.generate(2, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: paddingLarge,
                        vertical: paddingSmall,
                      ),
                      child: CommonShimmer(
                        child: Container(
                          height: 20.sp,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 260.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: paddingLarge,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(right: paddingLarge),
                            child: _ProductCardSkeleton(),
                          );
                        },
                      ),
                    ),
                    gapLarge,
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    final isLight = context.theme.brightness == Brightness.light;

    return Container(
      width: 160.w,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(color: context.borderColor),
      ),
      child: CommonShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius - 4),
                ),
              ),
            ),
            gapSmall,
            Container(
              height: 12.sp,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            gapSmall,
            Container(
              height: 16.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Gap(4),
            Container(
              height: 14.sp,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20.sp,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 28.w,
                  width: 28.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const CommonShimmer({super.key, required this.child, this.enabled = true});

  @override
  State<CommonShimmer> createState() => _CommonShimmerState();
}

class _CommonShimmerState extends State<CommonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final isLight = Theme.of(context).brightness == Brightness.light;
    final baseColor = isLight ? Colors.grey.shade200 : Colors.grey.shade800;
    final highlightColor = isLight ? Colors.grey.shade50 : Colors.grey.shade700;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.1, 0.5, 0.9],
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent - 0.5) * 2,
      0.0,
      0.0,
    );
  }
}
