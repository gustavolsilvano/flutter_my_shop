import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/edit_product_screen.dart';
import 'package:flutter_my_shop/widgets/confirm_dialog.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  var isDeleting = false;

  void _handleEdit(BuildContext context) {
    Navigator.of(context)
        .pushNamed(EditProductScreen.routeName, arguments: widget.id);
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
    setState(() {
      isDeleting = true;
    });
    if (context.mounted) {
      await Provider.of<Products>(context, listen: false)
          .deleteProduct(widget.id, context);
    }
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 50,
          child: IconButton(
            onPressed: () => _handleEdit(context),
            icon: const Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          width: 50,
          child: isDeleting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: () => _handleDelete(context),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error),
        )
      ]),
    );
  }
}
