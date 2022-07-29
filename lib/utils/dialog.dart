import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

class ShowDialog {
  static show(
    BuildContext context, {
    required String content,
    List<Widget>? actions,
    Widget? widget,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).notify),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content),
              if (widget != null) widget,
            ],
          ),
          actions: actions ??
              [
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
