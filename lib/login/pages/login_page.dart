import 'package:flutter/material.dart';
import 'package:passwd_manager_client/login/widgets/user_chip.dart';

class LoginPage extends StatelessWidget {

  final List<String> userList;

  const LoginPage({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
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
              children: [
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
                      overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surfaceVariant),
                      shadowColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
                      elevation: const MaterialStatePropertyAll(5),
                      animationDuration: const Duration(milliseconds: 1000),
                      visualDensity: const VisualDensity(vertical: 0.1),
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      "Add User",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

