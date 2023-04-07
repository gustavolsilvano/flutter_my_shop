import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';

class ImagePreviewInput extends StatefulWidget {
  final TextEditingController _imageUrlController;
  final Function(String value) onSubmit;
  final GlobalKey<FormState> form;
  Product _editedProduct;

  ImagePreviewInput(
      this._imageUrlController, this.onSubmit, this._editedProduct, this.form,
      {super.key});

  @override
  State<ImagePreviewInput> createState() => _ImagePreviewInputState();
}

class _ImagePreviewInputState extends State<ImagePreviewInput> {
  final _imageUrlFocusNode = FocusNode();

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) return;
    if (widget.form.currentState?.validate() != null) return;
    setState(() {});
  }

  String? _validate(String? value) {
    print('VALIDATE');
    if (value == null || value.isEmpty) {
      return 'Please enter a image URL.';
    }
    if (!value.startsWith('http') && !value.startsWith('https')) {
      return 'Please enter a valid URL.';
    }
    print(value.endsWith('png'));
    if (!value.endsWith('png') &&
        !value.endsWith('jpg') &&
        !value.endsWith('jpeg')) {
      return 'Please enter a valid image URL.';
    }
    return null;
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: widget._imageUrlController.text.isEmpty
              ? const Text('Enter a Url')
              : FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(widget._imageUrlController.text),
                ),
        ),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Image URL',
            ),
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            controller: widget._imageUrlController,
            validator: _validate,
            focusNode: _imageUrlFocusNode,
            onFieldSubmitted: widget.onSubmit,
            onSaved: (value) {
              widget._editedProduct = Product(
                  id: widget._editedProduct.id,
                  title: widget._editedProduct.title,
                  description: value ?? '',
                  price: widget._editedProduct.price,
                  imageUrl: widget._editedProduct.imageUrl);
            },
          ),
        ),
      ],
    );
  }
}
