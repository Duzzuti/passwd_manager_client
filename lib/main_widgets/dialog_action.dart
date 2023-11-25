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

class DialogActionDialog extends StatelessWidget {

  final String actionName;
  final Widget actionDialog;

  const DialogActionDialog({
    super.key,
    required this.actionName,
    required this.actionDialog,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, actionName);
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          builder: (BuildContext context) => actionDialog
        );
      },
      child: Text(actionName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}

class DialogActionDialogWithoutPopping extends StatelessWidget {

  final String actionName;
  final Widget actionDialog;
  final bool dismissible;

  const DialogActionDialogWithoutPopping({
    super.key,
    required this.actionName,
    required this.actionDialog,
    this.dismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: dismissible,
          barrierColor: dismissible 
          ?  Colors.deepOrange.withOpacity(0.2)
          : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          builder: (BuildContext context) => actionDialog
        );
      },
      child: Text(actionName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}