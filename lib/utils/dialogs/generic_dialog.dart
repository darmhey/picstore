import 'package:flutter/material.dart';

/*
definition of a function that returns a map of 
key String and value generic nullable type T?
*/
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
  required Color textColor,
}) {
  //options = calling the optionsBuilder function
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[300],
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            style: TextButton.styleFrom(
              foregroundColor: textColor,
            ),
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              optionTitle,
            ),
          );
        }).toList(), // to list cos map returns an iterable and UI cannot display iterable
      );
    },
  );
}
