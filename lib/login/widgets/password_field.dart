import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordField extends StatefulWidget {

  final Function(String) onTextChanged;

  const PasswordField({
    super.key,
    required this.onTextChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();

}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
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
      obscureText: _obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        labelText: "Password",
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
        suffixIcon: _obscureText 
          ? IconButton(
            onPressed: () {setState(() {
              _obscureText = false;
            });},
            icon: const Icon(Icons.remove_red_eye),
            color: Colors.white,
            padding: const EdgeInsets.all(16),
          )
          : IconButton(
            onPressed: () {setState(() {
              _obscureText = true;
            });},
            icon: const Icon(Icons.remove_red_eye_outlined),
            color: Colors.red,
            padding: const EdgeInsets.all(16),
          ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.inversePrimary
      ),
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s")),
      ],
      focusNode: _focused,
    );
  }
}

