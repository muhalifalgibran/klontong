import 'package:get_it/get_it.dart';
import 'package:klontong/core/network/dio_client.dart';
import 'package:klontong/features/home/data/datasources/home_data_source.dart';
import 'package:klontong/features/home/data/repositories/home_repository_impl.dart';
import 'package:klontong/features/home/domain/repositories/home_repository.dart';
import 'package:klontong/features/home/domain/usecases/get_list_product.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
// since we don't use build_runner to generate the
// service locator, so we defined our classes manually
void setupLocator() {
  // dio client
  getIt.registerLazySingleton<DioClient>(
    () => DioClient.init(),
  );

  // repositories
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

  // datasources
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());

  // usecases
  getIt.registerLazySingleton(() => GetListProduct());
}
