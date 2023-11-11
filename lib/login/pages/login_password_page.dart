import 'package:flutter/material.dart';

class LoginPasswordPage extends StatelessWidget{

  const LoginPasswordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String user = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: TextButton(child: Text('LoginPasswordPage from User: $user'), onPressed: (){Navigator.pop(context);},),
    );
  }
}