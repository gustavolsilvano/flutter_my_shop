import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart_item.dart';

class OrderProductItem extends StatelessWidget {
  final CartItem product;

  const OrderProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${product.quantity}x \$${product.price}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
