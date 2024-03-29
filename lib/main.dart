import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:qrcode/firebase_options.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/provider/iap.dart';
import 'package:qrcode/provider/qrcode_provider.dart';
import 'package:qrcode/screen/home_page.dart';
import 'package:qrcode/utils/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Preferences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  QRCodeProvider qrCodeProvider = QRCodeProvider();
  IAP iap = IAP();

  Locale? _locale;

  final String defaultLocale = Platform.localeName;

  final List<Locale>? systemLocales = WidgetsBinding.instance?.window.locales;

  Future<void> setLocale(Locale value) async {
    setState(() {
      _locale = value;
    });
    await Preferences.setString('languageCode', value.languageCode);
    await Preferences.setString('countryCode', value.countryCode ?? '');
  }

  @override
  void initState() {
    Future<void>.microtask(() async {
      iap.initIAP();
      await Preferences.init();
      String languageCode = Preferences.getString('languageCode', '');
      String countryCode = Preferences.getString('countryCode', '');
      setState(() {
        if (languageCode.isNotEmpty) {
          _locale = Locale(languageCode, countryCode);
        } else {
          if(defaultLocale.length > 1){
            String first = defaultLocale.substring(0,2);
            String last = defaultLocale.substring(defaultLocale.length - 2,defaultLocale.length);
            _locale = Locale(first,last == 'TW' ? 'TW' : '');
            Preferences.setString('languageCode', first);
            if(last == 'TW'){
              Preferences.setString('countryCode', last);
            }
          }
          // if (defaultLocale == 'zh_Hant_TW') {
          //   _locale = const Locale('zh','TW');
          //   Preferences.setString('languageCode', 'zh');
          //   Preferences.setString('countryCode', 'TW');
          // }
        }
      });
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: qrCodeProvider),
        ChangeNotifierProvider.value(value: iap),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: MyApp.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.black87),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('zh', 'TW'),
          Locale('zh', ''),
          Locale('ar', ''),
          Locale('cs', ''),
          Locale('de', ''),
          Locale('el', ''),
          Locale('es', ''),
          Locale('fi', ''),
          Locale('fr', ''),
          Locale('he', ''),
          Locale('hu', ''),
          Locale('id', ''),
          Locale('hi', ''),
          Locale('it', ''),
          Locale('ja', ''),
          Locale('ko', ''),
          Locale('nl', ''),
          Locale('pl', ''),
          Locale('pt', ''),
          Locale('ro', ''),
          Locale('ru', ''),
          Locale('sk', ''),
          Locale('tr', ''),
          Locale('uk', ''),
          Locale('vi', ''),
        ],
        locale: _locale ?? const Locale('en', ''),
        home: const MyHomePage(),
      ),
    );
  }
}
