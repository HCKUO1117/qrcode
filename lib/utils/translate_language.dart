

import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/main.dart';

class TranslateLanguage {
  List<String> getLanguages(List<String> list) {
    List<String> listLang = [];

    for (var element in list) {
      listLang.add(getLanguageByContext(element));
    }

    return listLang;
  }

  String getLanguageByContext(String code) {
    switch (code) {
      case "name":
        return S.of(MyApp.navigatorKey.currentContext!).name;
      case "recommendation":
        return S.of(MyApp.navigatorKey.currentContext!).recommendation;
      case "errorReport":
        return S.of(MyApp.navigatorKey.currentContext!).errorReport;
      case "usageProblem":
        return S.of(MyApp.navigatorKey.currentContext!).usageProblem;
      case "other":
        return S.of(MyApp.navigatorKey.currentContext!).other;
      case "all":
        return S.of(MyApp.navigatorKey.currentContext!).all;
      default:
        return code;
    }
  }
}
