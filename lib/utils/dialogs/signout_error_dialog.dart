import 'package:flutter/material.dart';
import 'package:picstore/utils/dialogs/generic_dialog.dart';

Future<bool> showSignOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Sign out',
    textColor: Colors.black,
    content: 'Are you sure you want to sign out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
