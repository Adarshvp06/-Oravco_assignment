import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/core/theme/theme_provider.dart';
import 'package:oravco_assignment/core/widgets/common_appbar.dart';
import 'package:oravco_assignment/core/widgets/common_botton.dart';
import 'package:oravco_assignment/features/auth/view_model/auth_viewmodel.dart';
import 'package:oravco_assignment/core/utils/snackbar_utils.dart';
import 'package:oravco_assignment/core/services/local_storage_services.dart';

import '../widgets/settings_tile.dart';
import '../widgets/themeoption_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Settings',
        leadingButton: SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            gapLarge,

            Row(
              children: [
                Expanded(
                  child: ThemeOptionCard(
                    themeMode: ThemeMode.light,
                    currentMode: currentThemeMode,
                    title: 'Light',
                    icon: Icons.light_mode_rounded,
                    onTap: () {
                      ref
                          .read(themeProvider.notifier)
                          .setTheme(ThemeMode.light);
                    },
                  ),
                ),
                gap,
                Expanded(
                  child: ThemeOptionCard(
                    themeMode: ThemeMode.dark,
                    currentMode: currentThemeMode,
                    title: 'Dark',
                    icon: Icons.dark_mode_rounded,
                    onTap: () {
                      ref.read(themeProvider.notifier).setTheme(ThemeMode.dark);
                    },
                  ),
                ),
                gap,
                Expanded(
                  child: ThemeOptionCard(
                    themeMode: ThemeMode.system,
                    currentMode: currentThemeMode,
                    title: 'System',
                    icon: Icons.settings_brightness_rounded,
                    onTap: () {
                      ref
                          .read(themeProvider.notifier)
                          .setTheme(ThemeMode.system);
                    },
                  ),
                ),
              ],
            ),
            gapXL,

            Text(
              'Preferences',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            gapLarge,

            SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Manage app push alerts',
              onTap: () {
                showSuccessMessage('Notification settings coming soon!');
              },
            ),
            gapLarge,
            SettingsTile(
              icon: Icons.security_rounded,
              title: 'Security',
              subtitle: 'Change password or biometrics',
              onTap: () {
                showSuccessMessage('Security options coming soon!');
              },
            ),
            gapXXL,

            CommonButton(
              buttonLoading: ref.watch(authViewmodelProvider).isLoading,
              text: 'Log Out',
              buttonType: ButtonType.outlined,
              customBorderColor: AppColors.error.withValues(
                alpha: opacityStrong,
              ),
              textColor: AppColors.error,
              onPressed: () async {
                await ref.read(storageServiceProvider).setValue(key: 'is_logged_in', value: 'false');
                showSuccessMessage('Logged out successfully');
                if (context.mounted) {
                  context.goNamed(RouteNames.login);
                }
              },
            ),
            gapLarge,
          ],
        ),
      ),
    );
  }
}

