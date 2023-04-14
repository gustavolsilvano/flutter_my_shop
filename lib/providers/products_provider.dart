import 'dart:convert';
import 'dart:io';

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

  Future<void> fetchProducts() async {
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

  Future<void> editProduct(Product newProduct, BuildContext context) async {
    try {
      int index = _items.indexWhere((item) => item.id == newProduct.id);
      if (index == -1) return;
      _items[index] = newProduct;
      await ProductsServer().editProduct(newProduct);
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Not possible to edit product')));
    }
  }

  Future<void> deleteProduct(String productId, BuildContext context) async {
    try {
      _items.removeWhere((item) => item.id == productId);
      final result = await ProductsServer().deleteProduct(productId);
      if (result.statusCode >= 400) {
        throw const HttpException('Could not delete product.');
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
