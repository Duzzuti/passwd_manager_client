import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwd_manager_client/classes/user.dart';
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

  @override
  void initState() {
    super.initState();
    _focused.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focused.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      }.getDeco(context, "Username", _focused, null),
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

class ChooseUsernameField extends StatefulWidget {
  final List<User> users;
  final Function(String) onTextChanged;

  const ChooseUsernameField({
    required this.users,
    required this.onTextChanged,
    super.key,
  });

  @override
  State<ChooseUsernameField> createState() => _ChooseUsernameFieldState();

}

class _ChooseUsernameFieldState extends State<ChooseUsernameField> {

  InputFieldState state = InputFieldState.ERROR;
  
  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      displayStringForOption: (User user) => user.name,
      optionsBuilder: (textEditingValue){
        if(textEditingValue.text.isEmpty){
          return const Iterable<User>.empty();
        }
        return widget.users.where((element) => element.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (User user) {
        widget.onTextChanged(user.name);
        setState(() {
          state = InputFieldState.GOOD;
        });
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted)
      => TextFormField(
        controller: textEditingController,
        onChanged: (value) {
          widget.onTextChanged(value);
          if(widget.users.any((element) => element.name == value)){
            setState(() {
              state = InputFieldState.GOOD;
            });
          }else{
            setState(() {
              state = InputFieldState.ERROR;
            });
          }
        },
        cursorColor: Theme.of(context).colorScheme.secondary,
        obscureText: false,
        decoration: switch (state) {
          InputFieldState.STANDARD => StandardInputFieldDec(),
          InputFieldState.DISABLED => DisabledInputFieldDec(),
          InputFieldState.GOOD => GoodInputFieldDec(),
          InputFieldState.WARNING => WarningInputFieldDec(),
          InputFieldState.ERROR => ErrorInputFieldDec(),
        }.getDeco(context, "Username", focusNode, null),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.inversePrimary
        ),
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s")),
        ],
        focusNode: focusNode,
      ),
    );
  }
}

