import 'package:flutter/material.dart';
import 'package:passwd_manager_client/main_widgets/dialog_action.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

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
      actions: const <Widget>[
        DialogCancel(),
        DialogAction(actionName: "New", actionRoute: "/add_new"),
        DialogAction(actionName: "Existing", actionRoute: "/add_existing")
      ],
    );
  }
}

