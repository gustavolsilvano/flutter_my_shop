import 'dart:convert';
import 'package:flutter_my_shop/providers/product_model.dart';
import 'package:flutter_my_shop/server/api_server.dart';

class CreateProductResponse {
  final String name;
  const CreateProductResponse(this.name);
}

class ProductsServer extends API {
  String mainPath = '/products.json';

  Future<List<Product>> fetchProducts() async {
    final response = await super.get(mainPath);
    Map<String, dynamic> jsonBody = json.decode(response.body);
    List<Product> products = [];
    jsonBody.forEach((prodId, value) {
      products.add(Product(
          id: prodId,
          title: value['title'],
          price: value['price'],
          description: value['description'],
          isFavorite: value['isFavorite'],
          imageUrl: value['imageUrl']));
    });
    return products;
  }

  Future<Product> createProduct(Product product) async {
    String jsonProduct = json.encode({
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'isFavorite': product.isFavorite,
      'imageUrl': product.imageUrl
    });
    final response = await super.post(mainPath, jsonProduct);
    final jsonBody = json.decode(response.body);
    CreateProductResponse productResponse =
        CreateProductResponse(jsonBody['name']);
    Product newProduct = Product(
        id: productResponse.name,
        title: product.title,
        price: product.price,
        description: product.description,
        isFavorite: product.isFavorite,
        imageUrl: product.imageUrl);
    return newProduct;
  }
}
