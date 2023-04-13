import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/edit_product_screen.dart';
import 'package:flutter_my_shop/widgets/app_drawer.dart';
import 'package:flutter_my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static String routeName = '/user-products-screen';

  const UserProductsScreen({super.key});

  void goToCreateProduct(BuildContext context) {
    Navigator.of(context).pushNamed(EditProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => goToCreateProduct(context),
            icon: const Icon(Icons.add))
      ], title: const Text('Your Products')),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: productsData.fetchProducts,
        child: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                      children: [
                        UserProductItem(
                            productsData.items[i].id,
                            productsData.items[i].title,
                            productsData.items[i].imageUrl),
                        const Divider()
                      ],
                    )),
          ),
        ),
      ),
    );
  }
}
