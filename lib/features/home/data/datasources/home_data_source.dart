import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/models/product_model.dart';
import 'package:klontong/core/network/dio_client.dart';

abstract class HomeDataSource {
  Future<List<Product>> getProduct();
}

// we should not catch the error here since we treat our repository
// as DTO so our repository should return whether an error or the expected object
class HomeDataSourceImpl implements HomeDataSource {
  final _module = getIt<DioClient>();
  @override
  Future<List<Product>> getProduct() async {
    final api = await _module.get('products');
    // , in data source we just send the expected object/data or just throw the error from here.

    return api.data
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
  }
}
