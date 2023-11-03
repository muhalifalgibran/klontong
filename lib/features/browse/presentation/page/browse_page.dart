import 'package:flutter/material.dart';
import 'package:klontong/core/utlis/debouncer.dart';
import 'package:klontong/features/browse/presentation/providers/browse_provider.dart';
import 'package:klontong/features/home/presentation/providers/home_provider.dart';
import 'package:klontong/features/home/presentation/widgets/item_product_widget.dart';
import 'package:provider/provider.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final Debouncer _debounce = Debouncer(const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black54,
        title: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.search),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                    hintText: 'search',
                  ),
                  onChanged: (value) {
                    // put debouncer it will make our API call more efficient
                    _debounce.call(() {
                      context.read<HomeProvider>().searchProduct(value);
                      setState(() {});
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              provider.searchedProduct.length,
              (index) {
                // defining the margin at first and at end
                bool isEnd = provider.searchedProduct.length - 1 == index;
                bool isFirst = index == 0;
                return Container(
                  margin: EdgeInsets.only(
                    bottom: isEnd ? 80 : 20,
                    top: isFirst ? 20 : 0,
                  ),
                  child: ItemProductWidget(
                    data: provider.searchedProduct[index],
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}