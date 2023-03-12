import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String title;
  final String imageUrl;

  const ProductItem(this.productId, this.title, this.imageUrl, {super.key});

  void handleFavorite() {
    print('favorite');
  }

  void handleAddToCart() {
    print('cart');
  }

  void handleGoToProductDetails(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ProductDetailScreen.routeName, arguments: productId);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: handleFavorite,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: handleAddToCart,
            ),
          ),
          child: GestureDetector(
            onTap: () => handleGoToProductDetails(context),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
