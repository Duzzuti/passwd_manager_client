import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/dialogs/add_user_dialog.dart';
import 'package:passwd_manager_client/login/widgets/user_chip.dart';

class LoginPage extends StatelessWidget {

  final List<User> userList;

  const LoginPage({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemCount: userList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return UserChip(userList: userList, context : context, index: index);
              }
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: InputChip(
                    color: MaterialStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
                    shadowColor: Theme.of(context).colorScheme.inversePrimary,
                    elevation: 5,
                    padding: const EdgeInsets.all(4),
                    label: SizedBox(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Add User",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                    onPressed: () => showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                      builder: (BuildContext context) => const AddUserDialog(),
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
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}