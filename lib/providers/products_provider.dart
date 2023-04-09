import 'package:flutter_my_shop/server/products_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        isFavorite: false),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        isFavorite: false),
    Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        isFavorite: false),
    Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        isFavorite: false),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => (product.id == id));
  }

  void addProduct(Product newProduct) async {
    await ProductsServer().createProduct(newProduct);
    _items.add(newProduct);
    notifyListeners();
  }

  void editProduct(Product newProduct) {
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
