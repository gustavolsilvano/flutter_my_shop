import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.purple,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: theme.copyWith(
          colorScheme:
              theme.colorScheme.copyWith(secondary: Colors.deepOrange)),
      routes: {
        '/': (_) => ProductOverviewScreen(),
        ProductOverviewScreen.routeName: (_) => ProductOverviewScreen()
      },
    );
  }
}
