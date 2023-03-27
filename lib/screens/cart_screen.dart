import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = 'cart_screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    cart.items.forEach((_, item) => print(item.toString()));

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
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (_, i) => CartItem(
                        cart.items.values.toList()[i].id,
                        cart.items.values.toList()[i].price,
                        cart.items.values.toList()[i].quantity,
                        cart.items.values.toList()[i].title,
                      )))
        ],
      ),
    );
  }
}
