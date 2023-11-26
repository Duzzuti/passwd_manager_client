// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum InputFieldState{
  DISABLED,
  STANDARD,
  GOOD,
  WARNING,
  ERROR,
}

abstract class InputFieldDeco{
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon);
}

class StandardInputFieldDec extends InputFieldDeco{
  @override
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: focused.hasFocus
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.inversePrimary,
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 3,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}

class DisabledInputFieldDec extends InputFieldDeco{
  @override
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey.withOpacity(0.5)
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}

class GoodInputFieldDec extends InputFieldDeco{
  @override
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: focused.hasFocus
        ? Colors.green
        : Theme.of(context).colorScheme.inversePrimary,
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.lightGreen,
          width: 3,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}

class WarningInputFieldDec extends InputFieldDeco{
  @override
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: focused.hasFocus
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.inversePrimary,
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.amber,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.amberAccent,
          width: 3,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}

class ErrorInputFieldDec extends InputFieldDeco{
  @override
  InputDecoration getDeco(BuildContext context, String label, FocusNode focused, Widget? suffixIcon) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: focused.hasFocus
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.inversePrimary,
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.deepOrange,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.deepOrangeAccent,
          width: 3,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
