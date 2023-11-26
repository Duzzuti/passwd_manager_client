import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/widgets/field_input_decorations/field_decos.dart';
import 'package:passwd_manager_client/login/widgets/password_field.dart';
import 'package:passwd_manager_client/login/widgets/username_field.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

class AddExistingUserDialog extends StatefulWidget {
  static const double _padding = 8;
  const AddExistingUserDialog({
    super.key,
  });

  @override
  State<AddExistingUserDialog> createState() => _AddExistingUserDialogState();
}

class _AddExistingUserDialogState extends State<AddExistingUserDialog> {
  
  InputFieldState passwordFieldState = InputFieldState.ERROR;
  String _password = "";
  String _username = "";

  void onChangePassword(String value){
    setState(() {
      _password = value;
      if(value.isEmpty){
        passwordFieldState = InputFieldState.ERROR;
      }else{
        passwordFieldState = InputFieldState.WARNING;
      }
    });
  }

  void onChangeUsername(String value){
    setState(() {
      _username = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Add Existing User', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please enter an username:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AddExistingUserDialog._padding),

          ChooseUsernameField(
            onTextChanged: onChangeUsername,
            users: const [User(name: "UserA"), User(name: "UserB"), User(name: "UserC")],
          ),

          const SizedBox(height: AddExistingUserDialog._padding),

          Text('Please enter a new password:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AddExistingUserDialog._padding),

          PasswordField(
            onTextChanged: onChangePassword, 
            state: passwordFieldState
          ),
        ],
      ),
      actions: const <Widget>[
        DialogCancel(),
      ],
    );
  }
}