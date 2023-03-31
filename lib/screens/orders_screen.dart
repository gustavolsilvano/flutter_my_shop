import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/orders.dart';
import 'package:flutter_my_shop/widgets/app_drawer.dart';
import 'package:flutter_my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = '/orders_screen';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Your Orders')),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (_, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
