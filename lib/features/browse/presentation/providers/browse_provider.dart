import 'package:flutter/material.dart';
import 'package:klontong/core/entities/product.dart';

class BrowseProvider extends ChangeNotifier {
  List<Product> product = [];
  List<Product> searchedProduct = [];

  void setProduct(List<Product> pr) {
    product = pr;
  }

  void searchProduct(String name) {
    // (API doesn't provide search method by name) so we search locally
    searchedProduct = product
        .where(
          (element) => element.title.contains(name),
        )
        .toList();

    print(searchedProduct);
    print(product);
    notifyListeners();
  }
}
