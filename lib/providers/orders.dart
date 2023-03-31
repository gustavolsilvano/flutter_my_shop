import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime createdAt;

  get fixedAmount {
    return amount.toStringAsFixed(2);
  }

  Order(
      {required this.id,
      required this.amount,
      required this.products,
      required this.createdAt});
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            amount: total,
            createdAt: DateTime.now(),
            products: cartProducts));
    notifyListeners();
  }
}
