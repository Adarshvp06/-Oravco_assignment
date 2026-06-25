import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/features/home/view_model/home_screen_viewmodel.dart';
import 'package:oravco_assignment/features/home/widgets/home_header.dart';
import 'package:oravco_assignment/features/home/widgets/category_chips.dart';
import 'package:oravco_assignment/features/home/widgets/categorized_products_list.dart';
import 'package:oravco_assignment/features/home/widgets/category_grid.dart';
import 'package:oravco_assignment/features/home/widgets/home_loading_skeleton.dart';
import 'package:oravco_assignment/core/widgets/common_error_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(homeScreenViewmodelProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: paddingLarge,
            horizontal: paddingLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              gap,

              Expanded(
                child: productsAsyncValue.when(
                  loading: () => const ProductListingShimmer(),
                  error: (error, stack) => Center(
                    child: CommonErrorWidget(
                      error: error,
                      onRetry: () {
                        ref
                            .read(homeScreenViewmodelProvider.notifier)
                            .fetchProducts();
                      },
                    ),
                  ),
                  data: (products) {
                    final categories = [
                      'All',
                      ...products.map((p) => p.category ?? 'N/A').toSet(),
                    ];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryChips(categories: categories),
                        gapLarge,
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => ref
                                .read(homeScreenViewmodelProvider.notifier)
                                .fetchProducts(),
                            child: selectedCategory == 'All'
                                ? CategorizedProductsList(products: products)
                                :
                                 CategoryGrid(
                                    products: products,
                                    category: selectedCategory,
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
