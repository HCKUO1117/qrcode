import 'package:flutter/material.dart';
import 'package:qrcode/constants/languages.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/main.dart';
import 'package:qrcode/utils/preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  int currentValue = 0;

  @override
  void initState() {
    String language = Preferences.getString('languageCode', 'en');
    String country = Preferences.getString('countryCode', '');
    Future.delayed(Duration.zero, () {
      if (Languages.languages.indexWhere((element) =>
              element['country'] == language &&
              element['countryCode'] == country) !=
          -1) {
        setState(() {
          currentValue = Languages.languages.indexWhere((element) =>
              element['country'] == language &&
              element['countryCode'] == country);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).cancel)),
              TextButton(
                onPressed: () async {
                  await MyApp.of(context)?.setLocale(
                    Locale(
                      Languages.languages[currentValue]['country'],
                      Languages.languages[currentValue]['countryCode'],
                    ),
                  );
                  Navigator.pop(context, true);
                },
                child: Text(S.of(context).confirm),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: Languages.languages.length,
            itemBuilder: (context, index) {
              return languageTitle(
                index,
                image: Languages.languages[index]['image'],
                title: Languages.languages[index]['name'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget languageTitle(int id, {required String image, required String title}) {
    return InkWell(
      onTap: () {
        setState(() {
          currentValue = id;
        });
      },
      child: Container(
        color: id == currentValue ? Colors.black26 : Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 40,
            ),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
      ),
    );
  }

  String getLanguageByContext(
      BuildContext context, String code, String countryCode) {
    switch (code + countryCode) {
      case 'en':
        return 'English';
      case 'zhTW':
        return '中文(繁體)';
      //   case 'hi':
      //     return S.of(context).India;
      //   case 'es':
      //     return S.of(context).spanish;
      //   case 'fr':
      //     return S.of(context).french;
      //   case 'ar':
      //     return S.of(context).arabic;
      //   case 'ru':
      //     return S.of(context).russian;
      //   case 'id':
      //     return S.of(context).indonesian;
      //   case 'ja':
      //     return S.of(context).japanese;
      //   case 'ko':
      //     return S.of(context).Korean;
      //   case 'vi':
      //     return S.of(context).vietnamese;
      //   case 'ro':
      //     return S.of(context).romanian;
      //   case 'tr':
      //     return S.of(context).turkish;
      //   case 'it':
      //     return S.of(context).italian;
      //   case 'de':
      //     return S.of(context).german;
      //   case 'pt':
      //     return S.of(context).brazil;
      //   case 'hu':
      //     return S.of(context).hungary;
      //   case 'he':
      //     return S.of(context).hebrew;
      //   case 'th':
      //     return S.of(context).thailand;
      //   case 'nl':
      //     return S.of(context).Dutch;
      //   case 'sr':
      //     return S.of(context).serbian;
      //   case 'pl':
      //     return S.of(context).Polish;
      //   case 'fa':
      //     return S.of(context).persian;
      //   case 'ta':
      //     return S.of(context).Tamil;
      //
      // /// Stop support Kudish language due to some build issue and un-support from Flutter
      // /// please refer to https://pub.dev/packages/kurdish_localization
      //   case 'ku':
      //     return S.of(context).kurdish;
      //   case 'bn':
      //     return S.of(context).bengali;
      //   case 'uk':
      //     return S.of(context).ukrainian;
      //   case 'cs':
      //     return S.of(context).czech;
      //   case 'sv':
      //     return S.of(context).swedish;
      //   case 'fi':
      //     return S.of(context).finnish;
      //   case 'el':
      //     return S.of(context).greek;
      //   case 'km':
      //     return S.of(context).khmer;
      //   case 'kn':
      //     return S.of(context).kannada;
      //   case 'mr':
      //     return S.of(context).marathi;
      //   case 'bs':
      //     return S.of(context).bosnian;
      //   case 'ms':
      //     return S.of(context).malay;
      //   case 'lo':
      //     return S.of(context).lao;
      //   case 'sk':
      //     return S.of(context).slovak;
      //   case 'sw':
      //     return S.of(context).swahili;
      default:
        return code;
    }
  }
}
