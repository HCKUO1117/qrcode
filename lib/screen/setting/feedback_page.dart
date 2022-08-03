
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrcode/screen/widget/custom_text_field.dart';
import 'package:qrcode/utils/translate_language.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';

class FeedBackPage extends StatefulWidget {

  const FeedBackPage({
    Key? key,
  }) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  int currentRadio = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).feedback),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${S.of(context).feedbackType} :',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                _radioButtonGroup(Constants.feedbackTypes),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${S.of(context).explainFeedback} :',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: contentController,
                  label: S.of(context).yorContent,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (currentRadio == Constants.feedbackTypes.length - 1 &&
                        typeController.text.isEmpty) {
                      Fluttertoast.showToast(msg: S.of(context).typeEmpty);
                    } else {
                      if (contentController.text.isEmpty) {
                        Fluttertoast.showToast(msg: S.of(context).contentEmpty);
                      } else {
                        final Email email = Email(
                          body: contentController.text,
                          subject:
                              'Qr Code ${TranslateLanguage().getLanguageByContext(Constants.feedbackTypes[currentRadio])} : ${currentRadio == Constants.feedbackTypes.length - 1 ? typeController.text : ''}',
                          recipients: ['bad.tech.service@gmail.com'],
                          cc: [],
                          bcc: [],
                          attachmentPaths: [],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                      }
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      S.of(context).send,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _radioButtonGroup(List<String>? list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < list!.length; i++)
          Row(
            children: [
              Row(
                children: [
                  Radio<int>(
                    value: i,
                    groupValue: currentRadio,
                    activeColor: Colors.blue,
                    onChanged: (int? value) {
                      setState(() {
                        currentRadio = value!;
                      });
                    },
                  ),
                  Text(TranslateLanguage().getLanguageByContext(list[i])),
                ],
              ),
              const SizedBox(width: 32),
              if (i == list.length - 1 && currentRadio == i)
                Expanded(
                  child: CustomTextField(
                    controller: typeController,
                    label: S.of(context).enter,
                  ),
                ),
            ],
          )
      ],
    );
  }
}
