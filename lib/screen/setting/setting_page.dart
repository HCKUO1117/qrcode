import 'package:flutter/material.dart';
import 'package:qrcode/constants/constants.dart';
import 'package:qrcode/constants/languages.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/screen/setting/feedback_page.dart';
import 'package:qrcode/screen/setting/language_page.dart';
import 'package:qrcode/utils/preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int languageIndex = 0;

  bool vibrate = false;

  bool urlCheck = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getLanguageIndex();
      setState(() {
        vibrate = Preferences.getBool(Constants.vibrate, false);
        urlCheck = !Preferences.getBool(Constants.notShowUrlSafety, false);
      });
    });
    super.initState();
  }

  void getLanguageIndex() {
    String language = Preferences.getString('languageCode', 'en');
    String country = Preferences.getString('countryCode', '');

    if (Languages.languages.indexWhere((element) =>
            element['country'] == language &&
            element['countryCode'] == country) !=
        -1) {
      setState(() {
        languageIndex = Languages.languages.indexWhere((element) =>
            element['country'] == language &&
            element['countryCode'] == country);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).setting),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: ListView(
          children: [
            Text(
              S.of(context).language,
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
            Builder(builder: (context) {
              return titleButton(
                onTap: () async {
                  bool? change = await showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return const LanguagePage();
                    },
                  );
                  if (change ?? false) {
                    getLanguageIndex();
                  }
                },
                title: Languages.languages[languageIndex]['name'],
                image: Languages.languages[languageIndex]['image'],
              );
            }),
            const SizedBox(height: 40),
            Text(
              S.of(context).generalSetting,
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
            CheckboxListTile(
              value: vibrate,
              onChanged: (v) async {
                await Preferences.setBool(Constants.vibrate, v!);
                setState(() {
                  vibrate = v;
                });
              },
              title: Text(S.of(context).vibrate),
            ),
            CheckboxListTile(
              value: urlCheck,
              onChanged: (v) async {
                await Preferences.setBool(Constants.notShowUrlSafety, !v!);
                setState(() {
                  urlCheck = v;
                });
              },
              title: Text(S.of(context).urlNotify),
            ),
            const SizedBox(height: 40),
            Text(
              S.of(context).feedback,
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
            titleButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FeedBackPage(),
                    ),
                  );
                },
                title: S.of(context).feedback,
                icon: Icons.feedback_outlined)
          ],
        ),
      ),
    );
  }

  Widget titleButton({
    required Function() onTap,
    String? image,
    IconData? icon,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Row(
          children: [
            if (image != null)
              Image.asset(
                image,
                width: 40,
              ),
            if (icon != null) Icon(icon),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
      ),
    );
  }
}
