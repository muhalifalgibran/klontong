import 'package:flutter/material.dart';
import 'package:klontong/features/home/presentation/providers/home_provider.dart';
import 'package:klontong/features/home/presentation/widgets/item_product_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // _provider.getListProduct();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getListProduct();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value ||
          _scrollController.position.extentAfter < 500) {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels == 0) {
            // You're at the top.
            print('at top');
          } else {
            // you are at the above bottom
            print('at bottom');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            if (provider.product != [])
              Center(
                child: Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  children: List.generate(provider.product!.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ItemProductWidget(data: provider.product![index]),
                    );
                  }),
                ),
              )
          ],
        ),
      ),
    );
  }
}
