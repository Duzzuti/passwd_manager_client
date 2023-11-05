import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerW extends StatefulWidget {
  const ServerW({
    super.key,
  });

  @override
  State<ServerW> createState() => _ServerWState();
}

class _ServerWState extends State<ServerW> {
  String text = 'Hello, world!';
  void getString() async {
    var url = Uri.http('127.0.0.1:8080', '/');
    var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    setState(() {
      text = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        TextButton(onPressed: (){getString();}, child: const Text("Get String"))
      ],
    );
  }
}