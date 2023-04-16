import 'dart:convert';

import 'package:flutter_my_shop/providers/cart_item.dart';
import 'package:flutter_my_shop/providers/orders.dart';
import 'package:flutter_my_shop/server/api_server.dart';

class CreateOrderResponse {
  final String name;
  const CreateOrderResponse(this.name);
}

class OrderServer extends API {
  String mainPath = '/orders';

  Future<List<Order>> fetchAll() async {
    final response = await super.get('$mainPath.json');
    List<Order> orders = [];
    Map<String, dynamic> jsonBody = json.decode(response.body);
    jsonBody.forEach((orderId, order) {
      orders.add(Order(
        id: orderId,
        amount: order['amount'],
        products: (order['products'] as List<dynamic>)
            .map((cartItem) => CartItem(
                id: cartItem['id'],
                title: cartItem['title'],
                quantity: cartItem['quantity'],
                price: cartItem['price']))
            .toList(),
        createdAt: DateTime.parse(order['createdAt']),
      ));
    });

    return orders;
  }

  Future<Order> create(Order order) async {
    String jsonProduct = json.encode({
      'amount': order.amount,
      'products': order.products
          .map((product) => {
                'id': product.id,
                'price': product.price,
                'quantity': product.quantity,
                'title': product.title,
              })
          .toList(),
      'createdAt': order.createdAt.toIso8601String(),
    });
    final response = await super.post('$mainPath.json', jsonProduct);
    final jsonBody = json.decode(response.body);
    CreateOrderResponse orderResponse = CreateOrderResponse(jsonBody['name']);
    Order newOrder = Order(
      id: orderResponse.name,
      amount: order.amount,
      products: order.products,
      createdAt: order.createdAt,
    );
    return newOrder;
  }
}
