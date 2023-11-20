import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/widgets/password_field.dart';
import 'package:passwd_manager_client/login/widgets/username_field.dart';
import 'package:passwd_manager_client/main_widgets/dialog_action.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

class AddNewUserDialog extends StatefulWidget {
  const AddNewUserDialog({
    super.key,
  });

  @override
  State<AddNewUserDialog> createState() => _AddNewUserDialogState();
}

class _AddNewUserDialogState extends State<AddNewUserDialog> {
  String _username = "";
  String _password1 = "";
  String _password2 = "";
  static const double _padding = 8;

  void changeUsername(String value){
    setState(() {
      _username = value;
    });
  }

  void changePassword1(String value){
    setState(() {
      _password1 = value;
    });
  }

  void changePassword2(String value){
    setState(() {
      _password2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Add New User', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Please enter a username:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: _padding),
          UsernameField(onTextChanged: changeUsername),
          const SizedBox(height: _padding),
          Text('Please enter a new password:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: _padding),
          PasswordField(onTextChanged: changePassword1),
          const SizedBox(height: _padding),
          Text('Please repeat the password:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: _padding),
          PasswordField(onTextChanged: changePassword2),
          const SizedBox(height: _padding),
        ],
      ),
      actions: <Widget>[
        const DialogCancel(),
        DialogActionArgs(actionName: "Add User", actionRoute: "/loading_add_new_user", args: AddUserStruct(username: _username, password1: _password1, password2: _password2))
      ],
    );
  }
}