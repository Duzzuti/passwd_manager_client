import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwd_manager_client/login/widgets/field_input_decorations/field_decos.dart';

class PasswordField extends StatefulWidget {

  final Function(String) onTextChanged;
  final InputFieldState state;
  final String? content;

  const PasswordField({
    super.key,
    required this.onTextChanged,
    this.state = InputFieldState.STANDARD,
    this.content,
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
    IconButton sufButton = _obscureText 
      ? IconButton(
        onPressed: () {setState(() {
          _obscureText = false;
        });},
        icon: const Icon(Icons.remove_red_eye),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      )
      : IconButton(
        onPressed: () {setState(() {
          _obscureText = true;
        });},
        icon: const Icon(Icons.remove_red_eye_outlined),
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      );
    _controller.text = widget.content == null ? _controller.text : widget.content!;
    return TextFormField(
      enabled: widget.state != InputFieldState.DISABLED,
      controller: _controller,
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      cursorColor: Theme.of(context).colorScheme.secondary,
      obscureText: _obscureText,
      obscuringCharacter: "*",
      decoration: switch (widget.state) {
        InputFieldState.STANDARD => StandardInputFieldDec(),
        InputFieldState.DISABLED => DisabledInputFieldDec(),
        InputFieldState.GOOD => GoodInputFieldDec(),
        InputFieldState.WARNING => WarningInputFieldDec(),
        InputFieldState.ERROR => ErrorInputFieldDec(),
      }.getDeco(context, "Password", _focused, sufButton),
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

