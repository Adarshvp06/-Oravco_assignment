import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/core/routes/route_paths.dart';
import 'package:oravco_assignment/features/auth/view/authentication_screen.dart';
import 'package:oravco_assignment/features/home/view/homescreen.dart';
import 'package:oravco_assignment/features/navigation/view/navigation_screen.dart';
import 'package:oravco_assignment/features/splashscreen/view/splash_screen.dart';
import 'package:oravco_assignment/features/home/view/product_details_screen.dart';
import 'package:oravco_assignment/features/favorites/view/favorites_screen.dart';
import 'package:oravco_assignment/features/cart/view/cart_screen.dart';
import 'package:oravco_assignment/features/settings/view/settings_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final favoritesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'favorites');
final cartNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cart');
final profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePath.login,
        name: RouteNames.login,
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: RoutePath.productDetails,
        name: RouteNames.productDetails,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final idStr = state.pathParameters['id'] ?? '';
          final id = int.tryParse(idStr) ?? 0;
          final from = state.uri.queryParameters['from'] ?? '';
          return ProductDetailsScreen(productId: id, heroTagSuffix: from);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePath.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: favoritesNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePath.favorites,
                name: RouteNames.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: cartNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePath.cart,
                name: RouteNames.cart,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePath.settings,
                name: RouteNames.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});