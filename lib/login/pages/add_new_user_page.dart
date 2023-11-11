import 'package:flutter/material.dart';

class AddNewUserPage extends StatelessWidget{
  const AddNewUserPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(child: const Text("Add New User Page"), onPressed: (){Navigator.pop(context);},),
    );
  }
}