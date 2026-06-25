import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/core/extension/string_extension.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/features/home/model/product_model.dart';
import 'package:oravco_assignment/features/home/view_model/home_screen_viewmodel.dart';
import 'package:oravco_assignment/features/home/widgets/product_listing_item.dart';
import 'package:oravco_assignment/features/home/widgets/promo_banner.dart';

class CategorizedProductsList extends ConsumerWidget {
  final List<ProductModel> products;

  const CategorizedProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final Map<String, List<ProductModel>> groupedProducts = {};
    for (var product in products) {
      groupedProducts
          .putIfAbsent(product.category ?? 'N/A', () => [])
          .add(product);
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const PromoBanner(),
        gapLarge,

        ...groupedProducts.entries.map((entry) {
          final categoryName = entry.key;
          final categoryProducts = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoryName.capitalize,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          categoryName;
                    },
                    child: Text(
                      'See all',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 260.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
                  itemCount: categoryProducts.length,
                  itemBuilder: (context, index) {
                    final product = categoryProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: paddingLarge),
                      child: ProductListingItem(
                        product: product,
                        heroTagSuffix: 'home',
                        onTap: () {
                          context.pushNamed(
                            RouteNames.productDetails,
                            pathParameters: {'id': product.id.toString()},
                            queryParameters: {'from': 'home'},
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              gapLarge,
            ],
          );
        }),
      ],
    );
  }
}
