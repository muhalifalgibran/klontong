import 'package:flutter/material.dart';
import 'package:klontong/core/entities/product.dart';

class ItemProductWidget extends StatelessWidget {
  final Product data;
  final double? width;
  const ItemProductWidget({
    required this.data,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // using decoration for imperative UI
      // than Card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white70,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      // height: 320,
      // -24 for margin at the parent
      // because we put two item in each row
      width: width ?? MediaQuery.of(context).size.width / 2 - 40,
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    data.imgUrl ??
                        'https://encrypted-tbn0.gstatic.com/images?q='
                            'tbn:ANd9GcTHov6Y_Xm6MoAYJ_YcbjSPYwSTmIdps6b4Y5EQUxGp&s',
                    height: 250,
                  ),
                ),
                const SizedBox(height: 4),
                // title
                Text(
                  data.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                // price and ratings
                Row(
                  children: [
                    Text(
                      '\$${data.price.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '⭐️${data.rating.rate.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
