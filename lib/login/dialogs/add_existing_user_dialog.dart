import 'package:flutter/material.dart';

class AddExistingUserDialog extends AlertDialog {
  const AddExistingUserDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Add Existing User', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Text('Do you wanna create a new user or add an existing one?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: const <Widget>[
      ],
    );
  }
}