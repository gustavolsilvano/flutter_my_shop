import 'package:flutter/material.dart';
import 'package:flutter_my_shop/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl, {super.key});

  void _handleEdit(BuildContext context) {
    Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          onPressed: () => _handleEdit(context),
          icon: const Icon(Icons.edit),
          color: Theme.of(context).primaryColor,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error)
      ]),
    );
  }
}
