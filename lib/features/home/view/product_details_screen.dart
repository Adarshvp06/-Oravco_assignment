import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oravco_assignment/core/utils/snackbar_utils.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extension/theme_extension.dart';
import '../../../core/widgets/common_botton.dart';
import '../../../core/widgets/common_error_widget.dart';
import '../model/product_model.dart';
import '../view_model/product_details_viewmodel.dart';
import '../../favorites/view_model/favorites_viewmodel.dart';
import '../../cart/view_model/cart_viewmodel.dart';
import 'package:oravco_assignment/core/routes/route_paths.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final int productId;
  final String heroTagSuffix;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.heroTagSuffix = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productDetailsProvider(productId));
    final uiState = ref.watch(productDetailsUiProvider(productId));
    final uiNotifier = ref.read(productDetailsUiProvider(productId).notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(favoritesProvider).any((p) => p.id == productId)
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: AppColors.error,
            ),
            onPressed: () {
              final product = productAsyncValue.asData?.value;
              if (product != null) {
                HapticFeedback.lightImpact();
                ref.read(favoritesProvider.notifier).toggleFavorite(product);
                final isFav = ref
                    .read(favoritesProvider)
                    .any((p) => p.id == product.id);
                if (isFav) {
                  showSuccessMessage('Added to Favorites');
                } else {
                  showErrorMessage('Removed from Favorites');
                }
              }
            },
          ),
          gapLarge,
        ],
      ),
      body: productAsyncValue.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
        error: (error, stack) => Center(
          child: CommonErrorWidget(
            error: error,
            onRetry: () {
              ref.invalidate(productDetailsProvider(productId));
            },
          ),
        ),
        data: (ProductModel product) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'product-image-${product.id}-$heroTagSuffix',
                        child: Container(
                          height: 280.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              largeBorderRadius,
                            ),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(paddingLarge),
                          child: CachedNetworkImage(
                            imageUrl: product.image ?? '',
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: 48.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    gapXL,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: paddingLarge,
                            vertical: paddingSmall + 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: opacityLow,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            (product.category ?? '').toUpperCase(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),
                            gapSmall,
                            Text(
                              product.rating?.rate?.toString() ?? '0.0',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            gapSmall,
                            Text(
                              '(${product.rating?.count ?? 0} reviews)',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.brightness == Brightness.light
                                    ? Colors.grey.shade500
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    gapLarge,

                    Text(
                      product.title ?? '',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 22.sp,
                      ),
                    ),
                    gapLarge,

                    Text(
                      'Description',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapSmall,
                    Text(
                      product.description ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.brightness == Brightness.light
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        height: 1.5,
                      ),
                    ),
                    gapXXL,
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(
                left: paddingLarge,
                right: paddingLarge,
                top: paddingLarge,
                bottom: MediaQuery.of(context).padding.bottom + paddingLarge,
              ),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.white
                    : context.colorScheme.surface,
                border: Border(top: BorderSide(color: context.borderColor)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Price',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.brightness == Brightness.light
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                          ),
                        ),
                        gapTiny,
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$${((product.price ?? 0.0) * uiState.quantity).toStringAsFixed(2)}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        gapSmall,
                        Container(
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.light
                                ? Colors.grey.shade100
                                : context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              defaultBorderRadius,
                            ),
                            border: Border.all(color: context.borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (uiState.quantity > 1) {
                                    uiNotifier.state = uiState.copyWith(
                                      quantity: uiState.quantity - 1,
                                    );
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: padding,
                                    vertical: paddingSmall,
                                  ),
                                  child: Icon(Icons.remove, size: 16),
                                ),
                              ),
                              Text(
                                '${uiState.quantity}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => uiNotifier.state = uiState
                                    .copyWith(quantity: uiState.quantity + 1),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: padding,
                                    vertical: paddingSmall,
                                  ),
                                  child: Icon(Icons.add, size: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapLarge,
                  Expanded(
                    child: CommonButton(
                      buttonLoading: false,
                      text: 'Add to Cart',
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        ref
                            .read(cartProvider.notifier)
                            .addToCart(product, uiState.quantity);
                        showSuccessMessage(
                          "${uiState.quantity} x ${product.title} has been added to your cart.",
                        );
                        context.go(RoutePath.cart);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
