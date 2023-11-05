import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/core/monitoring/monitoring.dart';
import 'package:klontong/features/home/data/datasources/home_data_source.dart';
import 'package:klontong/features/home/data/repositories/home_repository_impl.dart';
import 'package:klontong/features/home/domain/repositories/home_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../utility.dart';

class MockHomeDataSource extends Mock implements HomeDataSource {}

class MockMonitoring extends Mock implements Monitoring {}

void main() {
  late HomeDataSource dataSource;
  late HomeRepository repo;
  late Monitoring monitoring;

  setUpAll(() {
    dataSource = MockHomeDataSource();
    monitoring = MockMonitoring();

    registerTestLazySingleton(dataSource);
    registerTestLazySingleton<Monitoring>(monitoring);

    repo = HomeRepositoryImpl();
  });

  // tearDown(() {
  //   dataSource = MockHomeDataSource();

  //   registerTestLazySingleton(dataSource);
  // });

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

  test('Should return valid object', () async {
    // arrange
    when(() => dataSource.getProduct()).thenAnswer((_) async => product);

    // act
    final api = await repo.getProduct();

    // assert
    expect(api, Right(product));
  });

  test('should return failure when datasource thrown an error', () async {
    // arrange
    when(() => dataSource.getProduct()).thenThrow(Exception('Error Server'));

    when(() => monitoring.recordError(any(), any())).thenAnswer((_) async {});

    // act
    final api = await repo.getProduct();

    //verify
    expect(
        api,
        equals(const Left(
            DeviceFailure(message: 'Error occures. Try again later'))));
  });
}
