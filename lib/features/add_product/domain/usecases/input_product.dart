import 'package:dartz/dartz.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/features/add_product/domain/repositories/input_product_repository.dart';

class InputProduct {
  static final _repo = getIt<InputProductRepository>();

  Future<Either<Failure, void>> call(Product product) =>
      _repo.getProduct(product);
}
