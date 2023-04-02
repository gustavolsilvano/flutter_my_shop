import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/widgets/app_drawer.dart';
import 'package:flutter_my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static String routeName = '/user-products-screen';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
          title: const Text('Your Products')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(productsData.items[i].title,
                        productsData.items[i].imageUrl),
                    const Divider()
                  ],
                )),
      ),
    );
  }
}
