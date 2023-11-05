import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/models/product_model.dart';

void main() {
  test('should perform valid props', () {
    var rating = const Rating(
      rate: 1,
      count: 1,
    );

    Product model = const Product(
      id: 'abc',
      idCount: 1,
      title: 'title',
      price: 0.2,
      description: 'description',
      category: 'category',
      imgUrl: 'imgUrl',
      rating: Rating(
        rate: 1,
        count: 1,
      ),
    );
    var props = [
      'abc',
      1,
      'title',
      0.2,
      'description',
      'category',
      'imgUrl',
      rating,
    ];
    expect(model.props, equals(props));
  });
}
