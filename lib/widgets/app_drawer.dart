import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/orders_screen.dart';
import 'package:flutter_my_shop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void goToScreen(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Hello Friend'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () => goToScreen(context, '/'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () => goToScreen(context, OrdersScreen.routeName),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Manage Products'),
          onTap: () => goToScreen(context, UserProductsScreen.routeName),
        )
      ]),
    );
  }
}
