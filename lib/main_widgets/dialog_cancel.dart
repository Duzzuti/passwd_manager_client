import 'package:flutter/material.dart';

class DialogCancel extends StatelessWidget {
  const DialogCancel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context, 'Cancel'),
      child: Text('Cancel',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
