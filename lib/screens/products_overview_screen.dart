import 'package:flutter/material.dart';
import 'package:flutter_my_shop/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  static String routeName = 'product_overview_screen';

  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product overview'),
      ),
      body: ProductsGrid(),
    );
  }
}
