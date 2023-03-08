import 'package:flutter/material.dart';
import 'package:flutter_my_shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  void handleFavorite() {
    print('favorite');
  }

  void handleAddToCart() {
    print('cart');
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: handleFavorite,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: handleAddToCart,
        ),
      ),
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
