import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (_, i) => ProductItem(
            products[i].id, products[i].title, products[i].imageUrl));
  }
}
