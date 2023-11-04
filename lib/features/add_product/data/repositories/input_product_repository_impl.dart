import 'package:dartz/dartz.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/core/utlis/repository_mixin.dart';
import 'package:klontong/features/add_product/data/datasources/input_product_data_source.dart';
import 'package:klontong/features/add_product/domain/repositories/input_product_repository.dart';

class InputProductRepositoryImpl
    with RepositoryMixin
    implements InputProductRepository {
  static final _dataSource = getIt<InputProductDataSource>();
  @override
  Future<Either<Failure, void>> getProduct(Product product) =>
      callDataSource(() => _dataSource.inputProduct(product));
}
