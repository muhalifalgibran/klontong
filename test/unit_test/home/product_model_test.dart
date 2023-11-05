import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/models/product_model.dart';

void main() {
  ProductModel model = const ProductModel(
    id: 'abc',
    idCount: 1,
    title: 'title',
    price: 0.2,
    description: 'description',
    category: 'category',
    imgUrl: 'imgUrl',
    rating: RatingModel(
      rate: 1,
      count: 1,
    ),
  );

  Map<String, dynamic> json = {
    "id": 1,
    "_id": "abc",
    "title": "title",
    "price": 0.2,
    "description": "description",
    "category": "category",
    "image": "imgUrl",
    "rating": {
      "rate": 1,
      "count": 1,
    },
  };

  test('from json test', () {
    expect(model, ProductModel.fromJson(json));
  });

  test('should inherite the post', () {
    expect(model, isA<Product>());
  });
}
