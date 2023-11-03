import 'package:flutter/material.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/features/home/domain/usecases/get_list_product.dart';

class HomeProvider extends ChangeNotifier {
  late final List<Product> product;
  bool isError = false;

  void getListProduct() async {
    final data = await getIt<GetListProduct>().call();

    data.fold(
      (failure) {
        isError = true;
      },
      (dataProduct) {
        product = dataProduct;
      },
    );
    notifyListeners();
  }
}
