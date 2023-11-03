import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final int idCount;
  final String title;
  final num price;
  final String description;
  final String category;
  final String? imgUrl;
  final Rating rating;

  const Product({
    required this.id,
    required this.idCount,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imgUrl,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        idCount,
        title,
        price,
        description,
        category,
        imgUrl,
        rating,
      ];
}

class Rating extends Equatable {
  final num rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
