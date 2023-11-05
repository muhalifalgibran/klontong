import 'package:flutter/material.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/features/browse/presentation/page/detail_product_page.dart';
import 'package:klontong/features/home/presentation/providers/home_provider.dart';
import 'package:klontong/features/home/presentation/widgets/item_product_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _provider.getListProduct();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getListProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    // since our API doesn't provide an ideal data for pagination
    // so we make manual pagination
    if (provider.product != [] && provider.product.isNotEmpty) {
      return _ListProduct(products: provider.product, amount: 10);
    }
    if (provider.isError) {
      return const Center(
        child: Text('Something is wrong..'),
      );
    }
    return const Center(
      child: Text('Fetch data...'),
    );
  }
}

class _ListProduct extends StatefulWidget {
  final int amount;
  final List<Product> products;
  const _ListProduct({
    required this.products,
    required this.amount,
  });

  @override
  State<_ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<_ListProduct> {
  final ScrollController _scrollController = ScrollController();
  List<Product> _displayedProduct = [];
  bool isFetching = false;
  @override
  void initState() {
    super.initState();
    // store displayed product based on amount that we want to be displayed
    _displayedProduct = widget.products.sublist(0, widget.amount);
    _scrollController.addListener(() async {
      if (_scrollController.position.isScrollingNotifier.value ||
          _scrollController.position.extentAfter < 500) {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels == 0) {
            // at the top.
          } else {
            // at the above bottom
            if (_displayedProduct.length == widget.products.length) {
              // make early return so our app doesn't need to
              // always check and rebuild (setState) the widget tree
              return;
            }
            if (_displayedProduct.length != widget.products.length) {
              // set that it is like we fetch the data from API
              isFetching = true;
              setState(() {});
              // if the product length is less than widget amount. then, we store the rest of
              // the data in products

              // make delay like we fetch the data from API
              await Future.delayed(const Duration(milliseconds: 1250));

              if ((_displayedProduct.length - widget.products.length) <
                  widget.amount) {
                _displayedProduct.addAll(
                  widget.products.sublist(
                    _displayedProduct.length,
                    widget.products.length,
                  ),
                );
              } else {
                // but if the rest of the product is still more or equal than amount
                // then, we store the displayedProduct amount based on amount
                _displayedProduct.addAll(
                  widget.products.sublist(
                    _displayedProduct.length - 1,
                    widget.amount,
                  ),
                );
              }
            }

            isFetching = false;
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            if (_displayedProduct != [])
              Center(
                child: Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  children: List.generate(_displayedProduct.length, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailProductPage(
                                  product: _displayedProduct[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ItemProductWidget(
                              data: _displayedProduct[index],
                            ),
                          ),
                        ),
                        if (index == _displayedProduct.length - 1)
                          const SizedBox(
                            height: 68,
                          ),
                      ],
                    );
                  }),
                ),
              ),
            if (isFetching)
              Container(
                margin: const EdgeInsets.only(bottom: 80),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.data_saver_off),
                      SizedBox(width: 8),
                      Text('Fetch data...'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
