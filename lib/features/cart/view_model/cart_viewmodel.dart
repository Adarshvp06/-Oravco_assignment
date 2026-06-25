import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../home/model/product_model.dart';
import '../model/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  Box get _box => Hive.box('cart');

  @override
  List<CartItem> build() {
    final cached = _box.get('items');
    if (cached is List) {
      return cached
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  void _saveToBox(List<CartItem> items) {
    _box.put('items', items.map((e) => e.toJson()).toList());
  }

  void addToCart(ProductModel product, int quantity) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    List<CartItem> newList;
    if (existingIndex >= 0) {
      final existingItem = state[existingIndex];
      newList = List<CartItem>.from(state);
      newList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      newList = [...state, CartItem(product: product, quantity: quantity)];
    }
    state = newList;
    _saveToBox(newList);
  }

  void removeFromCart(int productId) {
    final newList = state.where((item) => item.product.id != productId).toList();
    state = newList;
    _saveToBox(newList);
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else {
      final newList = state.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList();
      state = newList;
      _saveToBox(newList);
    }
  }

  void clearCart() {
    state = [];
    _saveToBox([]);
  }

  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + ((item.product.price ?? 0.0) * item.quantity));
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
