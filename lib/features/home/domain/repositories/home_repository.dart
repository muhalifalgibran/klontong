import 'package:dartz/dartz.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Product>>> getProduct();
}
