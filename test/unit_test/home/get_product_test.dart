import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/features/home/domain/repositories/home_repository.dart';
import 'package:klontong/features/home/domain/usecases/get_list_product.dart';
import 'package:mocktail/mocktail.dart';

import '../utility.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repo;
  late GetListProduct usecase;

  List<Product> product = const [
    Product(
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
    ),
    Product(
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
    ),
  ];

  setUpAll(() {
    repo = MockHomeRepository();
    registerTestLazySingleton(repo);
    usecase = GetListProduct();
  });

  test('Should return valid object', () async {
    // arrange
    when(() => repo.getProduct()).thenAnswer(
      (_) async => Right(product),
    );

    // act
    final api = await usecase.call();

    // assert
    expect(api, Right(product));
  });

  test('Should return Left of failure', () async {
    // arrange
    when(() => repo.getProduct()).thenAnswer(
      (_) async => const Left(ServerFailure()),
    );

    // act
    final api = await usecase.call();

    // assert
    expect(api, const Left(ServerFailure()));
  });
}
