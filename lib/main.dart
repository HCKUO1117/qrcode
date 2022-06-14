import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/provider/qrcode_provider.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/utils/judge_qrcode_data_type.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  QRCodeProvider qrCodeProvider = QRCodeProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: qrCodeProvider),
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('zh', 'TW'), // Spanish, no country code
        ],
        locale: const Locale('zh', 'TW'),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool haveResult = false;

  QRViewController? controller;

  bool flashOn = false;

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async {
                            controller!.flipCamera();
                          },
                          icon: const Icon(
                            Icons.autorenew,
                            color: Colors.white,
                          )),
                      IconButton(
                        onPressed: () async {
                          controller!.toggleFlash();
                          bool? flash = await controller!.getFlashStatus();
                          if (flash ?? false) {
                            setState(() {
                              flashOn = true;
                            });
                          } else {
                            setState(() {
                              flashOn = false;
                            });
                          }
                        },
                        icon: flashOn
                            ? const Icon(
                                Icons.flash_on,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.flash_off,
                                color: Colors.white,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (haveResult) return;

      Vibrate.vibrate();

      final QRCodeDataType type =
          JudgeQrcodeDataType().judgeType(scanData.code ?? '');

      setState(() {
        haveResult = true;
      });
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScannedPage(
            type: type,
            result: scanData,
          ),
        ),
      );
      setState(() {
        haveResult = false;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
