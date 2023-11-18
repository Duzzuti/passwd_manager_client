import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';

class LoadingLoginPage extends StatelessWidget{
  const LoadingLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin = ModalRoute.of(context)!.settings.arguments as UserLogin;
    return Scaffold(
      body: TextButton(child: Text("LoadingLoginPage with\nUsername: ${userLogin.user}\nPassword: ${userLogin.password}"), onPressed: (){Navigator.pop(context);},),
    );
  }
}