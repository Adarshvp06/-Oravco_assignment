import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../home/model/product_model.dart';

class FavoritesViewModel extends Notifier<List<ProductModel>> {
  Box get _box => Hive.box('favorites');

  @override
  List<ProductModel> build() {
    final cached = _box.get('items');
    if (cached is List) {
      return cached
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  void toggleFavorite(ProductModel product) {
    List<ProductModel> newList;
    if (state.any((p) => p.id == product.id)) {
      newList = state.where((p) => p.id != product.id).toList();
    } else {
      newList = [...state, product];
    }
    state = newList;
    _box.put('items', newList.map((e) => e.toJson()).toList());
  }

  bool isFavorite(int productId) {
    return state.any((p) => p.id == productId);
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesViewModel, List<ProductModel>>(
      FavoritesViewModel.new,
    );
