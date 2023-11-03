import 'package:dartz/dartz.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/core/error/failure.dart';
import 'package:klontong/core/utlis/repository_mixin.dart';
import 'package:klontong/features/home/data/datasources/home_data_source.dart';
import 'package:klontong/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl with RepositoryMixin implements HomeRepository {
  static final _dataSource = getIt<HomeDataSource>();
  @override
  Future<Either<Failure, List<Product>>> getProduct() =>
      callDataSource(() => _dataSource.getProduct());
}
