import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/core/monitoring/monitoring.dart';
import 'package:klontong/features/add_product/data/datasources/input_product_data_source.dart';
import 'package:klontong/features/add_product/data/repositories/input_product_repository_impl.dart';
import 'package:klontong/features/add_product/domain/repositories/input_product_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../home/utility.dart';

class MockInputProductDataSource extends Mock
    implements InputProductDataSource {}

class MockMonitoring extends Mock implements Monitoring {}

class FakeProduct extends Fake implements Product {}

void main() {
  late InputProductDataSource dataSource;
  late InputProductRepository repo;
  late Monitoring monitoring;

  setUp(() {
    dataSource = MockInputProductDataSource();
    monitoring = MockMonitoring();

    registerTestLazySingleton<InputProductDataSource>(dataSource);
    registerTestLazySingleton<Monitoring>(monitoring);
    registerFallbackValue(FakeProduct());

    repo = InputProductRepositoryImpl();
  });

  var product = const Product(
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

  test('should return failure when datasource thrown an error', () async {
    // arrange
    when(() => dataSource.inputProduct(any()))
        .thenThrow(Exception('Error Server'));

    when(() => monitoring.recordError(any(), any())).thenAnswer((_) async {});

    // act
    final api = await repo.inputProduct(product);

    //verify
    verify(() => dataSource.inputProduct(any())).called(1);
    expect(
        api,
        equals(const Left(
            DeviceFailure(message: 'Error occures. Try again later'))));
  });
}
