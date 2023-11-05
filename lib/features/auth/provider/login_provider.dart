import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginProvider extends ChangeNotifier {
  bool isSuccessLogin = false;
  bool isLoggedIn = false;
  Future login(String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      final box = await Hive.openBox('auth');
      box.put('isLoggedIn', true);
      isSuccessLogin = true;
      notifyListeners();
      return;
    }
    isSuccessLogin = false;

    notifyListeners();
  }

  void checkLogin() async {
    if (!Hive.isBoxOpen('auth')) {
      await Hive.openBox('auth');
    }
    final auth = await Hive.openBox('auth');
    isLoggedIn = auth.get('isLoggedIn');
    notifyListeners();
  }
}
