import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/providers/orders.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/cart_screen.dart';
import 'package:flutter_my_shop/screens/edit_product_screen.dart';
import 'package:flutter_my_shop/screens/orders_screen.dart';
import 'package:flutter_my_shop/screens/product_detail_screen.dart';
import 'package:flutter_my_shop/screens/products_overview_screen.dart';
import 'package:flutter_my_shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme =
      ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: theme.copyWith(
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.deepOrange)),
        routes: {
          '/': (_) => const ProductOverviewScreen(),
          ProductOverviewScreen.routeName: (_) => const ProductOverviewScreen(),
          ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          OrdersScreen.routeName: (_) => const OrdersScreen(),
          UserProductsScreen.routeName: (_) => const UserProductsScreen(),
          EditProductScreen.routeName: (_) => const EditProductScreen(),
        },
      ),
    );
  }
}
