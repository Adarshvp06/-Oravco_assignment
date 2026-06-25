import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';

import '../../../core/extension/theme_extension.dart';
import '../../cart/view_model/cart_viewmodel.dart';


class NavigationScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsCount = ref.watch(cartProvider).fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: appShadow),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          backgroundColor: context.colorScheme.brightness == Brightness.dark
              ? AppColors.surfaceDark
              : context.theme.bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: context.theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              context.theme.bottomNavigationBarTheme.unselectedItemColor,
          selectedLabelStyle: context.theme.bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle:
              context.theme.bottomNavigationBarTheme.unselectedLabelStyle,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (int index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: cartItemsCount > 0
                  ? Badge(
                      label: Text('$cartItemsCount'),
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(Icons.shopping_bag_outlined),
                    )
                  : const Icon(Icons.shopping_bag_outlined),
              activeIcon: cartItemsCount > 0
                  ? Badge(
                      label: Text('$cartItemsCount'),
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(Icons.shopping_bag),
                    )
                  : const Icon(Icons.shopping_bag),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
