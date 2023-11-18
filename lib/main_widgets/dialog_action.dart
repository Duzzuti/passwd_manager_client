import 'package:flutter/material.dart';

class DialogAction extends StatelessWidget {

  final String actionName;
  final String actionRoute;

  const DialogAction({
    super.key,
    required this.actionName,
    required this.actionRoute,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, actionName);
        Navigator.pushNamed(context, actionRoute);
      },
      child: Text(actionName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}

class DialogActionArgs<T> extends StatelessWidget {

  final String actionName;
  final String actionRoute;
  final T args;

  const DialogActionArgs({
    super.key,
    required this.actionName,
    required this.actionRoute,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, actionName);
        Navigator.pushNamed(context, actionRoute, arguments: args);
      },
      child: Text(actionName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
