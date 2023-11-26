import 'package:flutter/material.dart';
import 'package:passwd_manager_client/main_widgets/dialog_cancel.dart';

class FormNotCompletedDialog extends AlertDialog {
  static const double _padding = 16;
  final bool usernameTooShort;
  final bool usernameTaken;
  final bool password1TooShort;
  final bool password2NotEqual;
  final bool secHintNotChecked;
  final bool weakHintNotCheckedWithWeakPassword;
  FormNotCompletedDialog({
    super.key,
    this.usernameTooShort = false,
    this.usernameTaken = false,
    this.password1TooShort = false,
    this.password2NotEqual = false,
    this.secHintNotChecked = false,
    this.weakHintNotCheckedWithWeakPassword = false,
  }){
    assert(usernameTooShort || usernameTaken || password1TooShort || password2NotEqual || secHintNotChecked || weakHintNotCheckedWithWeakPassword);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowButtonSpacing: 10,
      buttonPadding: const EdgeInsets.all(1),
      title: Text('Form Not Completed', 
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            if(usernameTooShort)
              Text('-> Username is too short',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: _padding),
            if(usernameTaken)
              Text('-> Username is already taken',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            if(password1TooShort)
              Text('-> Password is too short',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: _padding),
            if(password2NotEqual)
              Text('-> Passwords are not equal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: _padding),
            if(secHintNotChecked)
              Text('-> Security hint is not checked',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: _padding),
            if(weakHintNotCheckedWithWeakPassword)
              Text('-> Weak password hint is not checked',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: _padding),
          ],
        ),
      ),
      actions:  const <Widget>[
        DialogBack(),
      ],
    );
  }
}
