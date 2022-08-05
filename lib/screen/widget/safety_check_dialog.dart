import 'package:flutter/material.dart';
import 'package:qrcode/constants/constants.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/utils/preferences.dart';

class SafetyCheckDialog extends StatefulWidget {
  final String url;

  const SafetyCheckDialog({Key? key, required this.url}) : super(key: key);

  @override
  State<SafetyCheckDialog> createState() => _SafetyCheckDialogState();
}

class _SafetyCheckDialogState extends State<SafetyCheckDialog> {
  bool notShow = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).notify),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).soonOpen),
          SelectableText(
            widget.url,
            style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '※ ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Text(
                  S.of(context).safetyNotify,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                  value: notShow,
                  onChanged: (v) {
                    setState(() {
                      notShow = v!;
                    });
                  }),
              Text(S.of(context).notShowAgain),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            S.of(context).cancel,
          ),
        ),
        TextButton(
          onPressed: () async {
            await Preferences.setBool(Constants.notShowUrlSafety, notShow);
            Navigator.pop(context, true);
          },
          child: Text(
            S.of(context).confirm,
          ),
        ),
      ],
    );
  }
}
