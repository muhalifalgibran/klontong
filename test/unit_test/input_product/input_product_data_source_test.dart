import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/network/dio_client.dart';
import 'package:klontong/core/network/firebase_storage_client.dart';
import 'package:klontong/features/add_product/data/datasources/input_product_data_source.dart';
import 'package:mocktail/mocktail.dart';
import '../home/utility.dart';

class MockFirebaseStorageClient extends Mock implements FirebaseStorageClient {}

class MockDioClient extends Mock implements DioClient {}

class MockFile extends Mock implements File {}

void main() {
  late FirebaseStorageClient firebaseStorageClient;
  late DioClient dio;
  late InputProductDataSource dataSource;
  late File fakeFile;

  Product product = const Product(
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

  setUpAll(() {
    firebaseStorageClient = MockFirebaseStorageClient();
    dio = MockDioClient();
    fakeFile = MockFile();

    registerTestLazySingleton(firebaseStorageClient);
    registerTestLazySingleton(dio);
    registerFallbackValue(fakeFile);

    dataSource = InputProductDataSourceImpl();
  });

  test('Should return expected Object', () async {
    // arrange
    when(() => dio.post(any(), data: any(named: 'data'))).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        data: {},
      ),
    );

    when(() => firebaseStorageClient.uploadProduct(any(), any())).thenAnswer(
      (_) async => '',
    );

    // act
    final api = dataSource.inputProduct(product);

    // validate
    expect(api, isA<void>());
  });
}
