import 'package:flutter/material.dart';

class DeleteAlertWidget extends StatelessWidget {
  const DeleteAlertWidget({
    super.key,
    required this.onTap,
  });
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete ?'),
      content: const Text(
          'Are you Sure delete this image from your transformation journey ?'),
      actions: [
        ElevatedButton(onPressed: onTap, child: const Text('Delete')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'))
      ],
    );
  }
}
