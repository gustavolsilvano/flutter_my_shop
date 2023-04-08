import 'package:flutter/material.dart';
import 'package:flutter_my_shop/providers/product_model.dart';

class ImagePreviewInput extends StatefulWidget {
  final TextEditingController _imageUrlController;
  final Function(String value) onSubmit;
  final GlobalKey<FormState> form;
  final Function(String? value) _onSave;

  Product _editedProduct;

  ImagePreviewInput(this._imageUrlController, this.onSubmit,
      this._editedProduct, this.form, this._onSave,
      {super.key});

  @override
  State<ImagePreviewInput> createState() => _ImagePreviewInputState();
}

class _ImagePreviewInputState extends State<ImagePreviewInput> {
  final _imageUrlFocusNode = FocusNode();

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) return;
    if (widget.form.currentState?.validate() == null) return;
    setState(() {});
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a image URL.';
    }
    if (!value.startsWith('http') && !value.startsWith('https')) {
      return 'Please enter a valid URL.';
    }
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
              onSaved: widget._onSave),
        ),
      ],
    );
  }
}
