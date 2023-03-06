import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => ProductOverviewScreen(),
        ProductOverviewScreen.routeName: (_) => ProductOverviewScreen()
      },
    );
  }
}
