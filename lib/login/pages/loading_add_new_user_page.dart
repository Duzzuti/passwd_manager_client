import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';

class LoadingAddNewUserPage extends StatelessWidget{
  const LoadingAddNewUserPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AddUserStruct addUserStruct = ModalRoute.of(context)!.settings.arguments as AddUserStruct;
    return Scaffold(
      body: TextButton(child: Text("LoadingAddNewUserPage with\nUsername: ${addUserStruct.username}\nPassword1: ${addUserStruct.password1}\nPassword2: ${addUserStruct.password2}"), onPressed: (){Navigator.pop(context);},),
    );
  }
}