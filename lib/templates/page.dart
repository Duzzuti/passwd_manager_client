import 'package:flutter/material.dart';

class Page extends StatelessWidget{
  const Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(child: const Text("Page"), onPressed: (){Navigator.pop(context);},),
    );
  }
}