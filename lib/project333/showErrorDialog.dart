import 'package:flutter/material.dart';

import 'constants.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: UgBlue,
          title: const Text('ERROR'),
          content: Text(text, style: TextStyle(color: UgYellow, fontSize: 14),),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: UgYellow, fontSize: 15),
                ))
          ],
        );
      });
}
