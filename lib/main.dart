import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/product_detail_screen.dart';
import 'package:flutter_my_shop/screens/products_overview_screen.dart';
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
        ChangeNotifierProvider(create: (_) => Cart())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: theme.copyWith(
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.deepOrange)),
        routes: {
          '/': (_) => ProductOverviewScreen(),
          ProductOverviewScreen.routeName: (_) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
