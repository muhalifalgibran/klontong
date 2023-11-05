import 'package:flutter/material.dart';
import 'package:klontong/app.dart';
import 'package:klontong/features/add_product/presentation/widgets/klontong_input_text.dart';
import 'package:klontong/features/auth/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      builder: (ctx, child) {
        final provider = ctx.watch<LoginProvider>();

        if (provider.isSuccessLogin) {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const App(),
              ),
            );
          });
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Klontong App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  KlontongInputTextWidget(
                    label: 'username',
                    hint: 'type your username',
                    controller: _usernameCtrl,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  KlontongInputTextWidget(
                    label: 'password',
                    hint: 'type your password',
                    obscure: true,
                    controller: _passCtrl,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.login(
                        _usernameCtrl.text,
                        _passCtrl.text,
                      );

                      //  else {
                      //     showError(context);
                      //   }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showError(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text('invalid username and password..'),
          ),
        );
      },
    );
  }
}
