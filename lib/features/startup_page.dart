import 'package:flutter/material.dart';
import 'package:klontong/features/auth/presentation/login_page.dart';
import 'package:klontong/features/auth/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../app.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      builder: (ctx, child) {
        final provider = ctx.watch<LoginProvider>();

        if (provider.isLoggedIn) {
          Future.delayed(const Duration(milliseconds: 750), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const App(),
              ),
            );
          });
        } else {
          Future.delayed(const Duration(milliseconds: 750), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          });
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'Klontong.',
              style: TextStyle(fontSize: 36),
            ),
          ),
        );
      },
    );
  }
}
