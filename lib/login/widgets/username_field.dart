import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwd_manager_client/login/widgets/field_input_decorations/field_decos.dart';

class UsernameField extends StatefulWidget {

  final Function(String) onTextChanged;
  final InputFieldState state;

  const UsernameField({
    super.key,
    required this.onTextChanged,
    this.state = InputFieldState.STANDARD,
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
      decoration: switch (widget.state) {
        InputFieldState.STANDARD => StandardInputFieldDec(),
        InputFieldState.DISABLED => DisabledInputFieldDec(),
        InputFieldState.GOOD => GoodInputFieldDec(),
        InputFieldState.WARNING => WarningInputFieldDec(),
        InputFieldState.ERROR => ErrorInputFieldDec(),
      }.getDeco(context, "Username", _focused, null, _controller),
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

