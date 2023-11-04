import 'package:dartz/dartz.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';

abstract class InputProductRepository {
  Future<Either<Failure, void>> getProduct(Product product);
}
