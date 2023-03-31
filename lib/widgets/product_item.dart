import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/providers/product_model.dart';
import 'package:flutter_my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void handleFavorite(Product product) {
    product.toggleFavoriteStatus();
  }

  void handleAddToCart(Cart cart, Product product, BuildContext context) {
    cart.addItem(product.id, product.price, product.title);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
            label: 'UNDO', onPressed: () => cart.removeSingleItem(product.id)),
        content: const Text(
          'Added item to cart!',
          textAlign: TextAlign.center,
        )));
  }

  void handleGoToProductDetails(BuildContext ctx, String productId) {
    Navigator.of(ctx)
        .pushNamed(ProductDetailScreen.routeName, arguments: productId);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (_, product, __) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => handleFavorite(product),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => handleAddToCart(cart, product, context),
            ),
          ),
          child: GestureDetector(
            onTap: () => handleGoToProductDetails(context, product.id),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
