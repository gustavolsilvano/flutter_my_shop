import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/orders.dart';
import 'package:flutter_my_shop/widgets/app_drawer.dart';
import 'package:flutter_my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = '/orders_screen';

  const OrdersScreen({super.key});

  Future<void> handleLoadOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Your Orders')),
      body: FutureBuilder(
        future: handleLoadOrders(context),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
              onRefresh: () => handleLoadOrders(context),
              child: Consumer<Orders>(
                builder: (_, orderData, __) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (_, i) => OrderItem(orderData.orders[i]),
                ),
              ));
        },
      ),
    );
  }
}
