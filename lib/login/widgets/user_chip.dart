import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/dialogs/login_user_dialog.dart';

class UserChip extends StatelessWidget {

  final List<User> userList;
  final int index;
  final BuildContext context;


  const UserChip({
    super.key,
    required this.userList,
    required this.context,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 10,
            child: InputChip(
              color: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
              shadowColor: Theme.of(context).colorScheme.tertiary,
              elevation: 5,
              padding: const EdgeInsets.all(4),
              label: SizedBox(
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.center,
                  userList[index].toString(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              onPressed: () => showDialog<String>(
                context: context,
                barrierDismissible: false,
                barrierColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                builder: (BuildContext context) => LoginUserDialog(user: userList[index]),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide.none,
              ),
              side: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}