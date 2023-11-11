import 'package:flutter/material.dart';

class AddExistingUserPage extends StatelessWidget{
  const AddExistingUserPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(child: const Text("Add Existing User Page"), onPressed: (){Navigator.pop(context);},),
    );
  }
}