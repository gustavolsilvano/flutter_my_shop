import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_shop/server/products_server.dart';

class Product with ChangeNotifier {
  String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void addId() {
    id = DateTime.now().toString();
  }

  Future<void> toggleFavoriteStatus() async {
    try {
      isFavorite = !isFavorite;
      notifyListeners();
      final result = await ProductsServer().updateFavorite(id, isFavorite);
      if (result.statusCode >= 400) {
        throw const HttpException('Error favoriting');
      }
    } catch (_) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
