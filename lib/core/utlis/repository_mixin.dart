import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:klontong/core/error/failure.dart';

// use mixin to reduce the boilerplate code
mixin RepositoryMixin {
  Future<Either<Failure, T>> callDataSource<T>(
    Future<T> Function() call,
  ) async {
    try {
      return Right(await call());
    } on DioException catch (e) {
      if (e.response!.statusCode! > 400 && e.response!.statusCode! < 500) {
        return Left(ClientFailure(message: e.error.toString()));
      } else if (e.response!.statusCode! > 500) {
        return Left(ServerFailure(message: e.error.toString()));
      } else {
        rethrow;
      }
    } catch (e) {
      // TODO: implement monitoring
      return const Left(
        DeviceFailure(
          message: "Error occures. Try again later",
        ),
      );
    }
  }
}
