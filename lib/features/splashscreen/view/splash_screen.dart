import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/gen/assets.gen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(splashScreenDelay);
    if (!mounted) return;
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(paddingLarge * 1.5),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Assets.pngs.splashScreenIcon.image(
                fit: BoxFit.cover,
                height: 100.w,
                width: 100.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
