import 'dart:io';

import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/network/dio_client.dart';
import 'package:klontong/core/network/firebase_storage_client.dart';

abstract class InputProductDataSource {
  Future<void> inputProduct(Product product);
}

class InputProductDataSourceImpl implements InputProductDataSource {
  final _module = getIt<DioClient>();
  final _fbStorage = FirabaseStorageClient();

  @override
  Future<void> inputProduct(Product product) async {
    // save the picture to firebase store and put it by userId
    // we input the image first
    final file = File(product.imgUrl!);
    await _fbStorage.uploadProduct(file, 'products').then((picUrl) async {
      // after successfully upload the image into firebase storage
      // we use the output(imageURL) as the parameter of our image in product
      await _module.post(
        'products',
        data: {
          "id": product.idCount,
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "category": product.category,
          "image": picUrl,
          "rating": {
            "rate": product.rating.rate,
            "count": product.rating.count,
          }
        },
      );
    });
  }
}
