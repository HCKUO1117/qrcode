import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart' as dynamsoft_barcode;
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart' as flutter_barcode_sdk;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/provider/qrcode_provider.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/utils/judge_qrcode_data_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  double qrWidth = 250;

  double qrHeight = 250;

  final _barcodeReader = flutter_barcode_sdk.FlutterBarcodeSdk();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _barcodeReader.setLicense(
          'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
      await _barcodeReader.init();
    });
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
                    onTap: () {
                      // ConnectWifi.connect({"ssid":"LONGINGO","password":"0932111861"});
                    },
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        cutOutWidth: qrWidth,
                        cutOutHeight: qrHeight,
                        borderColor: Colors.amberAccent,
                        borderWidth: 5,
                        borderLength: 30,
                      ),
                    ),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width / 2 - qrWidth / 2 + 8,
                      bottom: MediaQuery.of(context).size.height / 2 -
                          qrHeight / 2 -
                          MediaQuery.of(context).padding.top / 2 +
                          8,
                      child: GestureDetector(
                        onPanUpdate: (dragDetail) {
                          if (dragDetail.globalPosition.dx * 2 -
                                  MediaQuery.of(context).size.width >=
                              100) {
                            setState(() {
                              qrWidth = dragDetail.globalPosition.dx * 2 -
                                  MediaQuery.of(context).size.width;
                            });
                          }
                          if (dragDetail.globalPosition.dy * 2 -
                                  MediaQuery.of(context).size.height >=
                              100) {
                            setState(() {
                              qrHeight = dragDetail.globalPosition.dy * 2 -
                                  MediaQuery.of(context).size.height;
                            });
                          }
                        },
                        child: const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.open_in_full,
                            color: Colors.amberAccent,
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {

                            final image =
                                await ImagePicker().pickImage(source: ImageSource.gallery);

                            if (image != null) {
                              final croppedFile = await ImageCropper().cropImage(
                                sourcePath: image.path,
                                uiSettings: [
                                  AndroidUiSettings(
                                    toolbarTitle: S.of(context).choose,
                                    toolbarColor: Colors.black,
                                    toolbarWidgetColor: Colors.white,
                                    lockAspectRatio: false,
                                  )
                                ],
                              );
                              List<dynamsoft_barcode.BarcodeResult> results =
                                  await _barcodeReader.decodeFile(croppedFile?.path ?? '');

                              print(results[0].format + results[0].text);
                            }
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                          )),
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
                                color: Colors.yellow,
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
      drawer: const Drawer(),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (haveResult) return;

      Vibrate.vibrate();

      final QRCodeDataType type = JudgeQrcodeDataType().judgeType(scanData.code ?? '');

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

  void _onMultiResult(){

  }

  List<Barcode> _resultTransfer(List<dynamsoft_barcode.BarcodeResult> rawList){
    List<Barcode> barcodeResults = [];
    for(final element in rawList){

      BarcodeFormat format = BarcodeFormat.qrcode;
      switch (element.format) {
        case 'AZTEC':
          return barcode_widget.Barcode.aztec();
        case BarcodeFormat.codabar:
          return barcode_widget.Barcode.codabar();
        case BarcodeFormat.code39:
          return barcode_widget.Barcode.code39();
        case BarcodeFormat.code93:
          return barcode_widget.Barcode.code93();
        case BarcodeFormat.code128:
          return barcode_widget.Barcode.code128();
        case BarcodeFormat.dataMatrix:
          return barcode_widget.Barcode.dataMatrix();
        case BarcodeFormat.ean8:
          return barcode_widget.Barcode.ean8();
        case BarcodeFormat.ean13:
          return barcode_widget.Barcode.ean13();
        case BarcodeFormat.itf:
          return barcode_widget.Barcode.itf();
        case BarcodeFormat.maxicode:
        //TODO 沒有這個類型
          return barcode_widget.Barcode.qrCode();
        case BarcodeFormat.pdf417:
          return barcode_widget.Barcode.pdf417();
        case BarcodeFormat.qrcode:
          return barcode_widget.Barcode.qrCode();
        case BarcodeFormat.rss14:
        //TODO 沒有這個類型
          return barcode_widget.Barcode.code128();
        case BarcodeFormat.rssExpanded:
        //TODO 沒有這個類型
          return barcode_widget.Barcode.code128();
        case BarcodeFormat.upcA:
          return barcode_widget.Barcode.upcA();
        case BarcodeFormat.upcE:
          return barcode_widget.Barcode.upcE();
        case BarcodeFormat.upcEanExtension:
        //TODO 沒有這個類型
          return barcode_widget.Barcode.upcE();
        case BarcodeFormat.unknown:
          return barcode_widget.Barcode.qrCode();
      }
      barcodeResults.add(Barcode(element.text,));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
