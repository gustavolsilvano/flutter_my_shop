import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';
import 'package:flutter_my_shop/providers/products_provider.dart';
import 'package:flutter_my_shop/screens/user_products_screen.dart';
import 'package:flutter_my_shop/widgets/image_preview_input.dart';
import 'package:provider/provider.dart';

enum FieldsToValidate { description, title, price, imageUrl }

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
  bool _isInit = true;
  bool _isEdit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) return;
    _isInit = false;
    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (productId == null) return;
    _isEdit = true;
    _editedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    _imageUrlController.text = _editedProduct.imageUrl;
    super.didChangeDependencies();
  }

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

  void _saveForm(_) async {
    final isValid = _form.currentState?.validate() ?? false;
    if (!isValid) return;
    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    if (!_isEdit) {
      await Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct);
    }
    if (_isEdit) {
      await Provider.of<Products>(context, listen: false)
          .editProduct(_editedProduct);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamed(UserProductsScreen.routeName);
  }

  String? _validate(String? value, FieldsToValidate field) {
    switch (field) {
      case FieldsToValidate.description:
        return _checkDescription(value);
      case FieldsToValidate.price:
        return _checkPrice(value);
      case FieldsToValidate.title:
        return _checkTitle(value);
      default:
    }

    return null;
  }

  String? _checkTitle(String? value) {
    if (value == null || value.isEmpty) return 'Please provide a title.';
    return null;
  }

  String? _checkDescription(String? value) {
    if (value == null || value.isEmpty) return 'Please provide a description.';
    if (value.length < 10) {
      return 'Should be at least 10 characters';
    }
    return null;
  }

  String? _checkPrice(String? value) {
    if (value == null || value.isEmpty) return 'Please provide a price.';
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }
    if (double.parse(value) <= 0) {
      return 'Please enter a price greater than zero number.';
    }
    return null;
  }

  void _onSave(String? value, FieldsToValidate field) {
    switch (field) {
      case FieldsToValidate.title:
        _editedProduct = Product(
            id: _editedProduct.id,
            title: value ?? '',
            description: _editedProduct.description,
            price: _editedProduct.price,
            imageUrl: _editedProduct.imageUrl);
        break;
      case FieldsToValidate.price:
        _editedProduct = Product(
            id: _editedProduct.id,
            title: _editedProduct.title,
            description: _editedProduct.description,
            price: double.parse(value ?? ''),
            imageUrl: _editedProduct.imageUrl);
        break;
      case FieldsToValidate.description:
        _editedProduct = Product(
            id: _editedProduct.id,
            title: _editedProduct.title,
            description: value ?? '',
            price: _editedProduct.price,
            imageUrl: _editedProduct.imageUrl);
        break;

      case FieldsToValidate.imageUrl:
        _editedProduct = Product(
            id: _editedProduct.id,
            title: _editedProduct.title,
            description: _editedProduct.description,
            price: _editedProduct.price,
            imageUrl: value ?? '');
        break;

      default:
    }
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                          initialValue: _editedProduct.title,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              focusNextField(context, _priceFocusNode),
                          validator: (value) =>
                              _validate(value, FieldsToValidate.title),
                          onSaved: (value) =>
                              _onSave(value, FieldsToValidate.title)),
                      TextFormField(
                          initialValue: _editedProduct.price.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Price',
                          ),
                          focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (_) =>
                              focusNextField(context, _descriptionFocusNode),
                          validator: (value) =>
                              _validate(value, FieldsToValidate.price),
                          onSaved: (value) =>
                              _onSave(value, FieldsToValidate.price)),
                      TextFormField(
                          initialValue: _editedProduct.description,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          validator: (value) =>
                              _validate(value, FieldsToValidate.description),
                          onSaved: (value) =>
                              _onSave(value, FieldsToValidate.description)),
                      ImagePreviewInput(
                          _imageUrlController,
                          _saveForm,
                          _editedProduct,
                          _form,
                          (String? value) =>
                              _onSave(value, FieldsToValidate.imageUrl))
                    ],
                  ),
                )),
      ),
    );
  }
}
