import 'package:flutter/material.dart';
import 'package:klontong/core/di/service_locator.dart';
import 'package:klontong/features/home/presentation/providers/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<HomeProvider>().getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
