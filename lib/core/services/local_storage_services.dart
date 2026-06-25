import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final storageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

class LocalStorageService {
  Box get _settingsBox => Hive.box('settings');

  Future<void> setValue({required String key, required String value}) async {
    await _settingsBox.put(key, value);
  }

  Future<String?> getValue({required String key}) async {
    return _settingsBox.get(key) as String?;
  }

  String? getValueSync({required String key}) {
    return _settingsBox.get(key) as String?;
  }

  Future<void> clearAll() async {
    await _settingsBox.clear();
  }
}
