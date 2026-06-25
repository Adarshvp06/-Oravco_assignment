import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extension/theme_extension.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadingButton;
  final List<Widget>? actions;
  // final bool? showBackButton;
  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leadingButton,
    // this.showBackButton,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingButton ?? backButtonWithSafety(context),
      centerTitle: true,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
    );
  }

  Widget backButtonWithSafety(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        );
      },
    );
  }
}
