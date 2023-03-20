import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = 'cart_screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text('R\$ ${cart.totalAmount}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium
                                ?.color,
                          ))),
                  TextButton(onPressed: () {}, child: const Text('ORDER NOW'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
