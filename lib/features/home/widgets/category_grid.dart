import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/features/home/model/product_model.dart';
import 'package:oravco_assignment/features/home/widgets/product_listing_item.dart';

class CategoryGrid extends StatelessWidget {
  final List<ProductModel> products;
  final String category;

  const CategoryGrid({
    super.key,
    required this.products,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((p) => p.category == category)
        .toList();

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: paddingLarge,
        crossAxisSpacing: paddingLarge,
        childAspectRatio: 160.w / 260.w,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ProductListingItem(
          product: product,
          heroTagSuffix: 'grid',
          onTap: () {
            context.pushNamed(
              RouteNames.productDetails,
              pathParameters: {'id': product.id.toString()},
              queryParameters: {'from': 'grid'},
            );
          },
        );
      },
    );
  }
}
