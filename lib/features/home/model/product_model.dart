class ProductModel {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingModel? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: num.tryParse(json['price']?.toString() ?? ""),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null
          ? RatingModel.fromJson(Map<String, dynamic>.from(json['rating']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toJson(),
    };
  }
}

class RatingModel {
  final num? rate;
  final int? count;

  RatingModel({this.rate, this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: num.tryParse(json['rate']?.toString() ?? ""),
      count: int.tryParse(json['count']?.toString() ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
