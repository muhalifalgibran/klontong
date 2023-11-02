import 'package:get_it/get_it.dart';
import 'package:klontong/core/network/dio_client.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
void setupLocator() {
  getIt.registerLazySingleton<DioClient>(
    () => DioClient.init(),
  );
}
