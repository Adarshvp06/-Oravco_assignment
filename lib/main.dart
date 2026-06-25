import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/theme/theme_provider.dart';
import 'package:oravco_assignment/core/theme/app_theme.dart';
import 'package:oravco_assignment/core/routes/app_router.dart';
import 'package:oravco_assignment/core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  await Hive.openBox('cart');
  await Hive.openBox('settings');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeProvider);
              return MaterialApp.router(
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
