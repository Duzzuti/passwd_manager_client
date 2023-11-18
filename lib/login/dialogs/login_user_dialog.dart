import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/widgets/password_field.dart';
import 'package:passwd_manager_client/main_widgets/dialog_action.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

class LoginUserDialog extends StatefulWidget {

  final User user;

  const LoginUserDialog({
    super.key,
    required this.user,
  });

  @override
  State<LoginUserDialog> createState() => _LoginUserDialogState();
}

class _LoginUserDialogState extends State<LoginUserDialog> {
  String _password = "";

  void changeValue(String value){
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    PasswordField passwordField = PasswordField(onTextChanged: changeValue);
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Login as ${widget.user}', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Please enter the password for ${widget.user}:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          passwordField,
        ],
      ),
      actions: <Widget>[
        const DialogCancel(),
        DialogActionArgs<UserLogin>(actionName: "Login", actionRoute: "/loading_login", args: UserLogin(user: widget.user, password: _password)),
      ],
    );
  }
}