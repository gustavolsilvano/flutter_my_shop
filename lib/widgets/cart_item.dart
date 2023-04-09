import 'package:flutter/material.dart';
import 'package:flutter_my_shop/widgets/confirm_dialog.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final void Function() onRemoveItem;

  const CartItem(
      this.id, this.price, this.quantity, this.title, this.onRemoveItem,
      {super.key});

  Future<bool?> handleConfirmDismiss(
      DismissDirection direction, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => const ConfirmDialog(
            'Do you want to remove the item from the cart?'));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (direction) => handleConfirmDismiss(direction, context),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemoveItem(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${quantity * price}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
