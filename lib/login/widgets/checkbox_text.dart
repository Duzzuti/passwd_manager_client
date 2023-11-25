import 'package:flutter/material.dart';

class CheckboxText extends StatelessWidget {
  final bool checkBoxState;
  final String text;
  final Function(bool?) onChange;

  const CheckboxText({
    super.key,
    required this.checkBoxState,
    required this.text,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: Theme.of(context).colorScheme.primary,
          focusColor: Theme.of(context).colorScheme.primary,
          checkColor: Theme.of(context).colorScheme.onPrimary,
          side: const BorderSide(color: Colors.amber),
          value: checkBoxState,
          onChanged: onChange,
        ),
        Flexible(
          child: Text(text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: checkBoxState
                ? Colors.white
                : Colors.amber,
            ),
          ),
        ),
      ],
    );
  }
}