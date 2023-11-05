import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/features/home/domain/usecases/get_list_product.dart';

class HomeProvider extends ChangeNotifier {
  List<Product> product = [];
  bool isError = false;
  List<Product> searchedProduct = [];

  void getListProduct() async {
    final data = await getIt<GetListProduct>().call();

    data.fold(
      (failure) {
        isError = true;
      },
      (dataProduct) {
        product = dataProduct.reversed.toList();
      },
    );
    notifyListeners();
  }

  void searchProduct(String name) {
    // (API doesn't provide search method by name) so we search locally
    searchedProduct = product
        .where(
          (element) => element.title.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
    if (name == '') {
      searchedProduct.clear();
    }
    notifyListeners();
  }

  bool isLogout = false;

  void logout() async {
    if (!Hive.isBoxOpen('auth')) {
      await Hive.openBox('auth');
    }
    final auth = await Hive.openBox('auth');
    auth.put('isLoggedIn', false);
    isLogout = true;
    notifyListeners();
  }
}
