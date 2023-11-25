import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/constants.dart';
import 'package:passwd_manager_client/login/dialogs/form_not_completed_dialog.dart';
import 'package:passwd_manager_client/login/widgets/checkbox_text.dart';
import 'package:passwd_manager_client/login/widgets/field_input_decorations/field_decos.dart';
import 'package:passwd_manager_client/login/widgets/password_field.dart';
import 'package:passwd_manager_client/login/widgets/username_field.dart';
import 'package:passwd_manager_client/main_widgets/dialog_action.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

class AddNewUserDialog extends StatefulWidget {
  const AddNewUserDialog({
    super.key,
  });

  @override
  State<AddNewUserDialog> createState() => _AddNewUserDialogState();
}

class _AddNewUserDialogState extends State<AddNewUserDialog> {
  String _username = "";
  String _password1 = "";
  String _password2 = "";
  bool _passwordWeakAcceptBox = false;
  bool _passwordSecAcceptBox = false;
  InputFieldState userFieldState = InputFieldState.ERROR;
  InputFieldState password1FieldState = InputFieldState.ERROR;
  InputFieldState password2FieldState = InputFieldState.DISABLED;
  List<User> users = [const User(name: "User1"), const User(name: "User2"), const User(name: "User3")];
  static const double _padding = 6;

  void onChangeUsername(String value){
    setState(() {
      _username = value;
      if(value.length < MIN_USER_CHARACTERS){
        userFieldState = InputFieldState.ERROR;
      }else if(users.any((element) => element.name == value)){
        userFieldState = InputFieldState.ERROR;
      }else{
        userFieldState = InputFieldState.GOOD;
      }
    });
  }

  void onChangePassword1(String value){
    setState(() {
      _password1 = value;
      _passwordWeakAcceptBox = false;
      if(value.isEmpty){
        _password2 = "";
        password2FieldState = InputFieldState.DISABLED;
        password1FieldState = InputFieldState.ERROR;
      }else{
        password2FieldState = InputFieldState.ERROR;
        password1FieldState = InputFieldState.WARNING;
      }
      if(value.length >= MIN_NOWARN_PASSWORD_CHARACTERS){
        password1FieldState = InputFieldState.GOOD;
      }
      if(value == _password2 && value.isNotEmpty){
        password2FieldState = InputFieldState.GOOD;
      }
    });
  }

  void onChangePassword2(String value){
    setState(() {
      _password2 = value;
      if(_password1 == value){
        password2FieldState = InputFieldState.GOOD;
      }else{
        password2FieldState = InputFieldState.ERROR;
      }
    });
  }

  void onCheckPasswordWeakAcceptBox(bool? state){
    if(state == null) return;
    setState(() {
      _passwordWeakAcceptBox = state;
    });
  }

  void onCheckPasswordSecAcceptBox(bool? state){
    if(state == null) return;
    setState(() {
      _passwordSecAcceptBox = state;
    });
  }

  bool isFilled(){
    bool perfect = (userFieldState == InputFieldState.GOOD && password1FieldState == InputFieldState.GOOD && password2FieldState == InputFieldState.GOOD && _passwordSecAcceptBox);
    bool good = (userFieldState == InputFieldState.GOOD && password1FieldState == InputFieldState.WARNING && password2FieldState == InputFieldState.GOOD && _passwordWeakAcceptBox && _passwordSecAcceptBox);
    return perfect || good;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Add New User', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      //titlePadding: const EdgeInsets.only(top: 12, left: 16),
      contentPadding: const EdgeInsets.only(top: 4, left: 24, right: 24, bottom: 16),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please enter an username:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: _padding),
            UsernameField(onTextChanged: onChangeUsername, state: userFieldState),
            const SizedBox(height: _padding),
            Text('Please enter a new password:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: _padding),
            PasswordField(onTextChanged: onChangePassword1, state: password1FieldState),
            const SizedBox(height: _padding),
            Text('Please repeat the password:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: _padding),
            PasswordField(onTextChanged: onChangePassword2, state: password2FieldState, content: _password2),
            const SizedBox(height: _padding),
            password1FieldState == InputFieldState.GOOD
              ? const SizedBox()
              : CheckboxText(checkBoxState: _passwordWeakAcceptBox, onChange: onCheckPasswordWeakAcceptBox, text: 'I understand that i am taking a major risk by choosing a weak password'),
            CheckboxText(checkBoxState: _passwordSecAcceptBox, onChange: onCheckPasswordSecAcceptBox, text: 'I understand that the password is the ONLY way to access the user data and there is no way to recover it'),
          ],
        ),
      ),
      actions: <Widget>[
        const DialogCancel(),
        isFilled()
          ? DialogActionArgs(actionName: "Add User", actionRoute: "/loading_add_new_user", args: AddUserStruct(username: _username, password1: _password1, password2: _password2))
          : DialogActionDialogWithoutPopping(actionName: "Add User", actionDialog: FormNotCompletedDialog(
              usernameTooShort: userFieldState == InputFieldState.ERROR && _username.length < MIN_USER_CHARACTERS,
              usernameTaken: userFieldState == InputFieldState.ERROR && users.any((element) => element.name == _username),
              password1TooShort: password1FieldState == InputFieldState.ERROR,
              password2NotEqual: password2FieldState == InputFieldState.ERROR,
              secHintNotChecked: !_passwordSecAcceptBox,
              weakHintNotCheckedWithWeakPassword: !_passwordWeakAcceptBox && password1FieldState == InputFieldState.WARNING,
          ), dismissible: true,),
      ],
    );
  }
}