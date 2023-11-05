import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/models/product_model.dart';
import 'package:klontong/core/network/dio_client.dart';
import 'package:klontong/features/home/data/datasources/home_data_source.dart';
import 'package:mocktail/mocktail.dart';

import '../utility.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late DioClient client;
  late HomeDataSource dataSource;

  setUp(() {
    client = MockDioClient();
    registerTestLazySingleton(client);
    dataSource = HomeDataSourceImpl();
  });

  List<Product> product = const [
    ProductModel(
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
    ),
    ProductModel(
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
    ),
  ];

  List<Map<String, dynamic>> json = [
    {
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
    },
    {
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
    }
  ];

  test('Should return expected Object', () async {
    // arrange
    when(() => client.get(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(),
          data: json,
        ));

    // act
    final api = await dataSource.getProduct();

    // validate
    expect(api, equals(product));
  });

  test('Should verify that is calling client', () async {
    // arrange
    when(() => client.get(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(),
          data: json,
        ));

    // act
    await dataSource.getProduct();

    // verify
    verify(
      () => client.get(any()),
    ).called(1);
  });

  test('Should throw error when client is error', () async {
    // arrange
    when(() => client.get(any())).thenThrow(Exception());

    // act
    final api = dataSource.getProduct();

    // assert
    verify(
      () => client.get(any()),
    ).called(1);

    expect(api, throwsA(isA<Exception>()));
  });

  test('Should throw error when client is dio Error', () async {
    // arrange
    when(() => client.get(any()))
        .thenThrow(DioException(requestOptions: RequestOptions()));

    // act
    final api = dataSource.getProduct();

    // assert
    verify(
      () => client.get(any()),
    ).called(1);

    expect(api, throwsA(isA<DioException>()));
  });
}
