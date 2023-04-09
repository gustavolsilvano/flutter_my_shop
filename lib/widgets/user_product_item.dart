import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/edit_product_screen.dart';
import 'package:flutter_my_shop/widgets/confirm_dialog.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl, {super.key});

  void _handleEdit(BuildContext context) {
    Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
  }

  Future<bool?> handleConfirmDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) =>
            const ConfirmDialog('Do you want to delete this product?'));
  }

  void _handleDelete(BuildContext context) async {
    bool? confirmed = await handleConfirmDelete(context);
    if (confirmed == null || !confirmed) return;
    if (context.mounted) {
      Provider.of<Products>(context, listen: false).deleteProduct(id);
    }
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
            onPressed: () => _handleDelete(context),
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error)
      ]),
    );
  }
}
