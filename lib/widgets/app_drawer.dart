import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void goToOrdersScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
  }

  void goToProductsScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed('/');
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
          onTap: () => goToProductsScreen(context),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () => goToOrdersScreen(context),
        )
      ]),
    );
  }
}
