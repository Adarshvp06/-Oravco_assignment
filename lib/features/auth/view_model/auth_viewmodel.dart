import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/constants/constants.dart';
import '../../../core/exception/custom_exception.dart';
import '../../../core/services/local_storage_services.dart';

class AuthViewmodel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(loginDelay);
      if (email != 'test@oravco.com' || password != 'test@oravco.com') {
        throw const CustomException(
          message:
              'Invalid email or password. (Use: test@oravco.com / test@oravco.com)',
          type: ExceptionType.validation,
        );
      }
      
      // Save login state to local storage
      await ref.read(storageServiceProvider).setValue(key: 'is_logged_in', value: 'true');
    });
  }
}

final passwordVisibilityProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final authViewmodelProvider = AsyncNotifierProvider<AuthViewmodel, void>(
  AuthViewmodel.new,
);
