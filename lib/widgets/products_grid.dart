import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  bool showOnlyFavorites;

  ProductsGrid(this.showOnlyFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: showOnlyFavorites
            ? products.favoriteItems.length
            : products.items.length,
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: showOnlyFavorites
                  ? products.favoriteItems[i]
                  : products.items[i],
              child: const ProductItem(),
            ));
  }
}
