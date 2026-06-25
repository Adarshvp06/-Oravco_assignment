import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/product_model.dart';
import '../repository/home_repository.dart';

final productDetailsProvider = FutureProvider.family<ProductModel, int>((ref, id) async {
  final repository = ref.watch(homeRepositoryProvier);
  return repository.getProductById(id);
});

class ProductDetailsState {
  final int quantity;

  ProductDetailsState({
    this.quantity = 1,
  });

  ProductDetailsState copyWith({
    int? quantity,
  }) {
    return ProductDetailsState(
      quantity: quantity ?? this.quantity,
    );
  }
}

final productDetailsUiProvider = StateProvider.family<ProductDetailsState, int>((ref, id) {
  return ProductDetailsState();
});
