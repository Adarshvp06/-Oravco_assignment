import '../../home/model/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(Map<String, dynamic>.from(json['product'])),
      quantity: json['quantity'] as int,
    );
  }
}
