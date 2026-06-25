import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oravco_assignment/core/services/local_storage_services.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  static const _themeKey = 'theme_mode_key';

  @override
  ThemeMode build() {
    try {
      final storage = ref.read(storageServiceProvider);
      final savedTheme = storage.getValueSync(key: _themeKey);
      if (savedTheme != null) {
        return ThemeMode.values.firstWhere(
          (e) => e.name == savedTheme,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (_) {
      // Fallback to default
    }
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.setValue(key: _themeKey, value: themeMode.name);
    } catch (_) {
      // Fail silently
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
