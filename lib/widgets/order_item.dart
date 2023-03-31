import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_my_shop/widgets/order_product_item.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.Order order;

  const OrderItem(this.order, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  void expandOrder() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.fixedAmount}'),
          subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.createdAt)),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: expandOrder,
          ),
        ),
        if (_expanded)
          SizedBox(
            height: min(widget.order.products.length * 20 + 20, 100),
            child: ListView(
                children: widget.order.products
                    .map((product) => OrderProductItem(product))
                    .toList()),
          )
      ]),
    );
  }
}
