import 'package:dartz/dartz.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/features/home/domain/repositories/home_repository.dart';

class GetListProduct {
  static final _repo = getIt<HomeRepository>();

  Future<Either<Failure, List<Product>>> call() async =>
      await _repo.getProduct();
}
