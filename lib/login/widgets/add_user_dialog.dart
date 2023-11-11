import 'package:flutter/material.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Add User', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Text('Do you wanna create a new user or add an existing one?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text('Cancel',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'New');
            Navigator.pushNamed(context, "/add_new");
          },
          child: Text('New',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Existing');
            Navigator.pushNamed(context, "/add_existing");
          },
          child: Text('Existing',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }
}

