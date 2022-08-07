import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

class ShowDialog {
  static show(
    BuildContext context, {
    required String content,
    List<Widget>? actions,
    Widget? widget,
    bool barrierDismissible = true,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return WillPopScope( onWillPop: ()async{
          if(barrierDismissible){
            return true;
          }
          return false;
        },child: AlertDialog(
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
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    S.of(context).confirm,
                  ),
                ),
              ],
        ),);
      },
    );
  }
}
