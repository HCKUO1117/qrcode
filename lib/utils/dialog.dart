import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

class ShowDialog {
  static show(BuildContext context, {required String content}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                S.of(context).confirm,
              ),
            ),
          ],
        );
      },
    );
  }
}
