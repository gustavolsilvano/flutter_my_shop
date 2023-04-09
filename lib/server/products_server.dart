import 'dart:convert';

import 'package:flutter_my_shop/providers/product_model.dart';
import 'package:flutter_my_shop/server/api_server.dart';

class ProductsServer extends API {
  String mainPath = '/products.json';

  Future<void> createProduct(Product product) async {
    String jsonProduct = json.encode({
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'isFavorite': product.isFavorite,
      'imageUrl': product.imageUrl
    });
    await super.post(mainPath, jsonProduct);
  }
}
