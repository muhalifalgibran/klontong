import 'package:flutter/material.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/features/add_product/domain/usecases/input_product.dart';

enum InputProductStatus {
  loading,
  success,
  initial,
  failure,
}

class InputProductProvider extends ChangeNotifier {
  InputProductStatus status = InputProductStatus.initial;

  Future uploadProduct(Product product) async {
    final usecase = await getIt<InputProduct>().call(product);

    usecase.fold(
      (l) => status = InputProductStatus.failure,
      (r) => status = InputProductStatus.success,
    );
  }
}
