import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/cart_screen.dart';
import 'package:flutter_my_shop/widgets/app_drawer.dart';
import 'package:flutter_my_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_badge.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  static String routeName = 'product_overview_screen';

  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Products>(context, listen: false).findAll();
    super.didChangeDependencies();
  }

  bool _showOnlyFavorites = false;

  void handlePressCart(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Product overview'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                }
                if (selectedValue == FilterOptions.all) {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOptions.favorites,
                      child: Text('Only Favorites'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.all,
                      child: Text('Show All'),
                    )
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                CustomBadge(value: cart.totalQuantity.toString(), child: ch!),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => handlePressCart(context),
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
