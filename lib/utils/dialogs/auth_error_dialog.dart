import 'package:flutter/material.dart';
import 'package:picstore/auth/errors/auth_errors.dart';
import 'package:picstore/utils/dialogs/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    textColor: Colors.black,
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
