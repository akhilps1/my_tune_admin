import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopup {
  static void showPopup({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      }),
    );
  }
}
