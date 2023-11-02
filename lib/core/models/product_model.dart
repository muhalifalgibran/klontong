import 'package:klontong/core/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.idCount,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.imgUrl,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['_id'],
        idCount: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        imgUrl: json['image'],
        rating: RatingModel.fromJson(json['rating']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': imgUrl,
        'rating': RatingModel(
          rate: rating.rate,
          count: rating.count,
        ).toJson()
      };
}

class RatingModel extends Rating {
  const RatingModel({
    required super.rate,
    required super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(count: json['count'], rate: json['rate']);

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
