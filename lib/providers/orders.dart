import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/cart_item.dart';
import 'package:flutter_my_shop/server/order_server.dart';

class Order {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime createdAt;

  get fixedAmount {
    return amount.toStringAsFixed(2);
  }

  Order(
      {this.id,
      required this.amount,
      required this.products,
      required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'products': products,
      'createdAt': createdAt,
    };
  }
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> createOrder(List<CartItem> cartProducts, double total) async {
    Order order = Order(
        id: DateTime.now().toString(),
        amount: total,
        createdAt: DateTime.now(),
        products: cartProducts);
    await OrderServer().create(order);
    _orders.insert(0, order);
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    _orders = (await OrderServer().fetchAll()).reversed.toList();
    notifyListeners();
  }
}
