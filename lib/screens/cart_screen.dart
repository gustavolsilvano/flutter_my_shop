import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/providers/orders.dart';
import 'package:flutter_my_shop/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String routeName = 'cart_screen';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isCreatingOrder = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context, listen: false);

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    Future<void> handleCreateOrder() async {
      try {
        setState(() {
          _isCreatingOrder = true;
        });

        await orders.createOrder(cart.items.values.toList(), cart.totalAmount);
      } catch (_) {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Not possible to create order')));
      } finally {
        setState(() {
          _isCreatingOrder = false;
        });
      }
      cart.clear();
    }

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
                      label: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium
                                ?.color,
                          ))),
                  _isCreatingOrder
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: handleCreateOrder,
                          child: const Text('ORDER NOW'))
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
                      () => cart.removeItem(cart.items.keys.toList()[i]))))
        ],
      ),
    );
  }
}
