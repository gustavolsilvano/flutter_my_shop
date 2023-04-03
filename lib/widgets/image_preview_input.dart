import 'package:flutter/material.dart';

class ImagePreviewInput extends StatefulWidget {
  final TextEditingController _imageUrlController;

  const ImagePreviewInput(this._imageUrlController, {super.key});

  @override
  State<ImagePreviewInput> createState() => _ImagePreviewInputState();
}

class _ImagePreviewInputState extends State<ImagePreviewInput> {
  final _imageUrlFocusNode = FocusNode();

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) return;
    setState(() {});
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
            focusNode: _imageUrlFocusNode,
          ),
        ),
      ],
    );
  }
}
