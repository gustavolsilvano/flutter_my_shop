import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';
import 'package:flutter_my_shop/widgets/image_preview_input.dart';

class EditProductScreen extends StatefulWidget {
  static String routeName = '/edit-product-screen';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _editedProduct =
      Product(id: '', title: '', price: 0, description: '', imageUrl: '');

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void focusNextField(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _saveForm(_) {
    if (_form.currentState?.save == null) return;
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () => _saveForm(null), icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        focusNextField(context, _priceFocusNode),
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: value ?? '',
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    focusNode: _priceFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) =>
                        focusNextField(context, _descriptionFocusNode),
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value ?? ''),
                          imageUrl: _editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value ?? '',
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                  ),
                  ImagePreviewInput(
                      _imageUrlController, _saveForm, _editedProduct)
                ],
              ),
            )),
      ),
    );
  }
}
