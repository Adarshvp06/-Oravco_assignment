import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:oravco_assignment/features/home/model/product_model.dart';
import 'package:oravco_assignment/features/home/repository/home_repository.dart';

class HomeScreenViewmodel extends AsyncNotifier<List<ProductModel>> {
  @override
  FutureOr<List<ProductModel>> build() {
    return _repository.getProducts();
  }

  HomeRepository get _repository => ref.read(homeRepositoryProvier);

  Future<void> fetchProducts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repository.getProducts();
    });
  }
}

final homeScreenViewmodelProvider =
    AsyncNotifierProvider<HomeScreenViewmodel, List<ProductModel>>(
  HomeScreenViewmodel.new,
);

final selectedCategoryProvider = StateProvider<String>((ref) {
  return 'All';
});
