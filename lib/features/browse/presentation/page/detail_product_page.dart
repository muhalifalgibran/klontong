import 'package:flutter/material.dart';
import 'package:klontong/core/entities/product.dart';

class DetailProductPage extends StatelessWidget {
  final Product product;
  const DetailProductPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // image
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Image.network(
                    product.imgUrl ??
                        'https://encrypted-tbn0.gstatic.com/images?q='
                            'tbn:ANd9GcTHov6Y_Xm6MoAYJ_YcbjSPYwSTmIdps6b4Y5EQUxGp&s',
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      product.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // price and ratings
                    Text(
                      '\$${product.price.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '⭐️${product.rating.rate.toString()} (${product.rating.count.toString()})',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
