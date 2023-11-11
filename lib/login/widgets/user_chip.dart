import 'package:flutter/material.dart';

class UserChip extends StatelessWidget {

  final List<String> userList;
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
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary),
                shadowColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary),
                elevation: const MaterialStatePropertyAll(5),
                animationDuration: const Duration(milliseconds: 1000),
                
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/login_password", arguments: userList[index]);
              },
              child: Text(
                userList[index],
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}