import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/dummy/dummy_data.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/core/routes/route_paths.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(paddingLarge * 1.25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(dummyProfilePlaceholder),
                ),
              ),
            ),
            gap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.brightness == Brightness.light
                        ? Colors.grey.shade600
                        : Colors.grey.shade400,
                  ),
                ),
                Text('Guest User', style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            context.go(RoutePath.favorites);
          },
        ),
      ],
    );
  }
}
