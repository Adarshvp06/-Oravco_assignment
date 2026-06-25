import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/widgets/common_appbar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/widgets/no_item_found.dart';
import '../../home/widgets/product_listing_item.dart';
import '../view_model/favorites_viewmodel.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: CommonAppBar(
        title: "My Favorites",
        leadingButton: SizedBox.shrink(),
      ),
      body: favorites.isEmpty
          ? NoItemFound(
              title: 'No Favorites Yet',
              message: 'Explore products and add them to your favorites to view them here.',
              icon: Icons.favorite_outline_rounded,
              iconColor: AppColors.error,
              iconBackgroundColor: AppColors.error.withValues(alpha: opacityLow),
              buttonText: 'Explore Products',
              onPressed: () => context.go('/home'),
            )
          : _buildFavoritesGrid(context, favorites),
    );
  }



  Widget _buildFavoritesGrid(BuildContext context, List<dynamic> favorites) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: paddingLarge,
        crossAxisSpacing: paddingLarge,
        childAspectRatio: 160.w / 260.w,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];
        return ProductListingItem(
          product: product,
          heroTagSuffix: 'favorites',
          onTap: () {
            context.pushNamed(
              RouteNames.productDetails,
              pathParameters: {'id': product.id.toString()},
              queryParameters: {'from': 'favorites'},
            );
          },
        );
      },
    );
  }
}
