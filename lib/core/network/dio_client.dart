import 'package:dio/dio.dart';
import 'package:klontong/core/utils/constants.dart';

// we create dio client as Lazy singleton, so whenever this class
// is called, it just calls the latest instance if it already instanciated
// from other class, if there is no instanciate before, it should instanciate
// for the first time.
class DioClient with DioMixin {
  static const _url = 'https://crudcrud.com/api/${Constants.crudCredential}/';

  // instanciate
  static DioClient init() => DioClient._();

  // call as singleton
  DioClient._() {
    options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(milliseconds: 30000),
    );

    // this is base adapter for browser/native call
    // we shouldn't use like IOHttpClientAdapter, etc.
    httpClientAdapter = HttpClientAdapter();
  }
}
