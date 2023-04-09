import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String confirmationText;
  const ConfirmDialog(this.confirmationText, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Are you sure?'),
        content: Text(confirmationText),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'))
        ]);
  }
}
