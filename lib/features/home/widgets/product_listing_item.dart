import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/features/home/model/product_model.dart';
import 'package:oravco_assignment/features/favorites/view_model/favorites_viewmodel.dart';

class ProductListingItem extends ConsumerWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final String heroTagSuffix;

  const ProductListingItem({
    super.key,
    required this.product,
    this.onTap,
    this.heroTagSuffix = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(color: context.borderColor, width: 1),
        boxShadow: theme.brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            defaultBorderRadius,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(paddingSmall),
                            child: Hero(
                              tag: 'product-image-${product.id}-$heroTagSuffix',
                              child: CachedNetworkImage(
                                imageUrl: product.image ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(
                                        Icons.broken_image_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: paddingSmall,
                        right: paddingSmall,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ref
                                .read(favoritesProvider.notifier)
                                .toggleFavorite(product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(paddingSmall),
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.light
                                  ? Colors.white.withValues(alpha: opacityHigh)
                                  : context.colorScheme.surface.withValues(
                                      alpha: opacityHigh,
                                    ),
                              shape: BoxShape.circle,
                              boxShadow: theme.brightness == Brightness.light
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: opacityLow,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                              border: theme.brightness == Brightness.dark
                                  ? Border.all(
                                      color: context.borderColor,
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Icon(
                              ref
                                      .watch(favoritesProvider)
                                      .any((p) => p.id == product.id)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 18.sp,
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                gapSmall,
                // Category Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: paddingSmall + 2,
                    vertical: paddingTiny,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: opacityLow),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    (product.category ?? '').toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                gapSmall,
                // Product Title
                Text(
                  product.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                gap,
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 14.sp),
                    gapSmall,
                    Text(
                      product.rating?.rate?.toString() ?? '0.0',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    gapSmall,
                    Text(
                      '(${product.rating?.count ?? 0})',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        color: theme.brightness == Brightness.light
                            ? Colors.grey.shade500
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                gapLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${(product.price ?? 0.0).toStringAsFixed(2)}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Container(
                      height: 28.w,
                      width: 28.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
