import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oravco_assignment/core/widgets/common_appbar.dart';
import 'package:toastification/toastification.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extension/theme_extension.dart';
import '../../../core/widgets/common_botton.dart';
import '../../../core/widgets/no_item_found.dart';
import '../view_model/cart_viewmodel.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final theme = context.theme;
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : context.colorScheme.surface,
      appBar: CommonAppBar(title: "My Cart", leadingButton: SizedBox.shrink()),
      body: cartItems.isEmpty
          ? NoItemFound(
              title: 'Your Cart is Empty',
              message: 'Looks like you haven\'t added any items to your cart yet.',
              icon: Icons.shopping_bag_outlined,
              buttonText: 'Start Shopping',
              onPressed: () => context.go('/home'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingLarge,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item.product;

                      return Container(
                        margin: const EdgeInsets.only(bottom: paddingLarge),
                        padding: const EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.light
                              ? Colors.grey.shade50
                              : context.colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                            defaultBorderRadius,
                          ),
                          border: Border.all(color: context.borderColor),
                        ),
                        child: Row(
                          children: [
                            // Product Image Container
                            Container(
                              width: 80.w,
                              height: 80.w,
                              padding: const EdgeInsets.all(paddingSmall),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                                border: Border.all(color: context.borderColor),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: product.image ?? '',
                                fit: BoxFit.contain,
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
                            gapLarge,
                            // Info Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapSmall,
                                  Text(
                                    '\$${(product.price ?? 0.0).toStringAsFixed(2)}',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                  ),
                                  gapSmall,
                                  // Quantity Selector
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              theme.brightness ==
                                                  Brightness.light
                                              ? Colors.grey.shade100
                                              : context.colorScheme.surface,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: context.borderColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  cartNotifier.updateQuantity(
                                                    product.id ?? 0,
                                                    item.quantity - 1,
                                                  ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: padding,
                                                  vertical: paddingSmall,
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${item.quantity}',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  cartNotifier.updateQuantity(
                                                    product.id ?? 0,
                                                    item.quantity + 1,
                                                  ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: padding,
                                                  vertical: paddingSmall,
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                          color: AppColors.error,
                                        ),
                                        onPressed: () => cartNotifier
                                            .removeFromCart(product.id ?? 0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Sticky Bottom Bar
                Container(
                  padding: EdgeInsets.only(
                    left: paddingLarge,
                    right: paddingLarge,
                    top: paddingLarge,
                    bottom:
                        MediaQuery.of(context).padding.bottom + paddingLarge,
                  ),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.light
                        ? Colors.white
                        : context.colorScheme.surface,
                    border: Border(top: BorderSide(color: context.borderColor)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Subtotal',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.brightness == Brightness.light
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                            ),
                          ),
                          gapTiny,
                          Text(
                            '\$${cartNotifier.totalPrice.toStringAsFixed(2)}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      gapLarge,
                      Expanded(
                        child: CommonButton(
                          buttonLoading: false,
                          text: 'Place Order',
                          onPressed: () {
                            cartNotifier.clearCart();
                            toastification.show(
                              context: context,
                              type: ToastificationType.success,
                              style: ToastificationStyle.flatColored,
                              title: const Text('Order Placed Successfully'),
                              description: const Text(
                                'Thank you for shopping with us!',
                              ),
                              autoCloseDuration: const Duration(seconds: 3),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

}
