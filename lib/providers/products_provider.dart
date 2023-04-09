import 'dart:convert';

import 'package:flutter_my_shop/server/products_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Future<void> findAll() async {
    try {
      _items = await ProductsServer().fetchProducts();
      notifyListeners();
    } catch (e) {
      _items = [];
    }
  }

  Product findById(String id) {
    return _items.firstWhere((product) => (product.id == id));
  }

  Future<void> addProduct(Product newProduct, BuildContext context) async {
    try {
      await ProductsServer().createProduct(newProduct);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Not possible to create product')));
    }
  }

  Future<void> editProduct(Product newProduct) async {
    int index = _items.indexWhere((item) => item.id == newProduct.id);
    if (index == -1) return;
    _items[index] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }
}
