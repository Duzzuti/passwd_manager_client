import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsernameField extends StatefulWidget {

  final Function(String) onTextChanged;

  const UsernameField({
    super.key,
    required this.onTextChanged,
  });

  @override
  State<UsernameField> createState() => _UsernameFieldState();

}

class _UsernameFieldState extends State<UsernameField> {
  final FocusNode _focused = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focused.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focused.dispose();
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      cursorColor: Theme.of(context).colorScheme.secondary,
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Username",
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: _focused.hasFocus
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.inversePrimary,
        ),
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 3,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.inversePrimary
      ),
      keyboardType: TextInputType.name,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s")),
      ],
      focusNode: _focused,
    );
  }
}

