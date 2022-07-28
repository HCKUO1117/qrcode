import 'package:flutter/material.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart' as dynamsoft_barcode;
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart' as flutter_barcode_sdk;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/provider/qrcode_provider.dart';
import 'package:qrcode/res/app_colors.dart';
import 'package:qrcode/screen/barcode_history_page.dart';
import 'package:qrcode/screen/barcode_list_page.dart';
import 'package:qrcode/screen/choose_barcode_page.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/screen/widget/my_banner_ad.dart';
import 'package:qrcode/sql/history_db.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/judge_qrcode_data_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool haveResult = false;

  QRViewController? controller;

  bool flashOn = false;

  int selectIndex = 0;

  double qrWidth = 250;

  double qrHeight = 250;

  final _barcodeReader = flutter_barcode_sdk.FlutterBarcodeSdk();

  String version = '';

  bool multiMode = false;
  List<Barcode> multiScanList = [];

  double bottomSheetHeight = 50;

  late AnimationController expandController;
  late Animation<double> animation;

  late Animation<double> bubbleAnimation;
  late AnimationController bubbleAnimationController;

  bool inOtherPage = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      await _barcodeReader.setLicense(
          'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
      await _barcodeReader.init();
      setState(() {});
    });
    expandController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    bubbleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: bubbleAnimationController);
    bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  if (!inOtherPage)
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
                      bottom: MediaQuery.of(context).size.height / 2 - qrHeight / 2 + 8 -25,
                      child: GestureDetector(
                        onPanUpdate: (dragDetail) {
                          if (dragDetail.globalPosition.dx * 2 -
                                  MediaQuery.of(context).size.width >=
                              100) {
                            setState(() {
                              qrWidth = dragDetail.globalPosition.dx * 2 -
                                  MediaQuery.of(context).size.width ;
                            });
                          }
                          if (dragDetail.globalPosition.dy * 2 -
                                      MediaQuery.of(context).size.height >=
                                  100- 50 &&
                              dragDetail.globalPosition.dy * 2 -
                                      MediaQuery.of(context).size.height <=
                                  MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top -
                                      MediaQuery.of(context).padding.bottom -
                                      180- 50) {
                            setState(() {
                              qrHeight = dragDetail.globalPosition.dy * 2 -
                                  MediaQuery.of(context).size.height + 50;
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
                  Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: Row(
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
                                setState(() {
                                  controller?.stopCamera();
                                  haveResult = true;
                                });
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
                                  if (croppedFile == null) {
                                    setState(() {
                                      controller?.resumeCamera();
                                      haveResult = false;
                                    });
                                    return;
                                  }

                                  List<dynamsoft_barcode.BarcodeResult> results =
                                      await _barcodeReader.decodeFile(croppedFile.path);
                                  List<Barcode> barcodeList = _resultTransfer(results);
                                  final list = <HistoryModel>[];
                                  for (final element in barcodeList) {
                                    final QRCodeDataType type =
                                        JudgeQrcodeDataType().judgeType(element.code ?? '');
                                    final model = HistoryModel(
                                      createDate: DateTime.now(),
                                      qrcodeType: element.format.formatName,
                                      contentType: type.name,
                                      content: element.code ?? '',
                                      favorite: false,
                                    );

                                    final id = await HistoryDB.insertData(
                                      model,
                                    );
                                    model.id = id;
                                    list.add(model);
                                  }
                                  list.sort((a, b) => b.createDate.compareTo(a.createDate));
                                  _pushPage(
                                    BarcodeListPage(
                                      histories: list,
                                    ),
                                  );
                                  setState(() {
                                    controller?.resumeCamera();
                                    haveResult = false;
                                  });
                                }
                                setState(() {
                                  controller?.resumeCamera();
                                  haveResult = false;
                                });
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
                      )),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Icon(
                              Icons.fast_forward,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/icons/pro_logo_icon.png',
                                height: 10,
                                width: 10,
                                color: Colors.orangeAccent,
                              ))
                        ]),
                        const SizedBox(height: 16),
                        FlutterSwitch(
                            value: multiMode,
                            width: 55,
                            height: 25,
                            valueFontSize: 12,
                            padding: 3,
                            activeColor: Colors.teal,
                            showOnOff: true,
                            onToggle: (value) {
                              setState(() {
                                multiMode = value;
                              });
                              if (value) {
                                expandController.forward();
                              } else {
                                setState(() {
                                  multiScanList.clear();
                                });
                                expandController.reverse();
                              }
                            }),
                        // Switch(
                        //   value: multiMode,
                        //   trackColor: MaterialStateProperty.all(Colors.grey),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       multiMode = value;
                        //     });
                        //     if (value) {
                        //       expandController.forward();
                        //     } else {
                        //       setState(() {
                        //         multiScanList.clear();
                        //       });
                        //       expandController.reverse();
                        //     }
                        //   },
                        // )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
                      child: SizeTransition(
                        axis: Axis.horizontal,
                        sizeFactor: animation,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).total + ' : ${multiScanList.length}'),
                                    Text(
                                      S.of(context).data +
                                          ' : ' +
                                          (multiScanList.isNotEmpty
                                              ? multiScanList.last.code ?? ''
                                              : ''),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (multiScanList.isEmpty) {
                                    Fluttertoast.showToast(msg: S.of(context).youHaveNotScan);
                                    return;
                                  }
                                  setState(() {
                                    controller?.pauseCamera();
                                    haveResult = true;
                                  });
                                  final list = <HistoryModel>[];
                                  for (var element in multiScanList) {
                                    final QRCodeDataType type =
                                        JudgeQrcodeDataType().judgeType(element.code ?? '');
                                    final model = HistoryModel(
                                      createDate: DateTime.now(),
                                      qrcodeType: element.format.formatName,
                                      contentType: type.name,
                                      content: element.code ?? '',
                                      favorite: false,
                                    );
                                    final id = await HistoryDB.insertData(
                                      model,
                                    );
                                    model.id = id;
                                    list.add(model);
                                  }
                                  list.sort((a, b) => b.createDate.compareTo(a.createDate));
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BarcodeListPage(
                                        histories: list,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    controller?.resumeCamera();
                                    haveResult = false;
                                    multiScanList.clear();
                                  });
                                },
                                child: Text(S.of(context).complete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const AdBanner(large: false,),
          ],
        ),
      ),
      onDrawerChanged: (isOpened) {
        setState(() {
          haveResult = isOpened;
        });
      },
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(''),
                  ),
                  drawerTitle(
                    onTap: () async {
                      controller?.stopCamera();
                      Navigator.pop(context);
                      _pushPage(const ChooseBarcodePage());
                      controller?.resumeCamera();
                    },
                    iconData: Icons.qr_code_2,
                    title: S.of(context).build,
                  ),
                  drawerTitle(
                    onTap: () async {
                      controller?.stopCamera();
                      Navigator.pop(context);
                      _pushPage(const BarcodeHistoryPage());
                      controller?.resumeCamera();
                    },
                    iconData: Icons.history,
                    title: S.of(context).history,
                  ),
                  drawerTitle(
                    onTap: () {},
                    iconData: Icons.settings,
                    title: S.of(context).setting,
                  ),
                  drawerTitle(
                    onTap: () {},
                    iconData: Icons.info_outline,
                    title: S.of(context).info,
                  ),
                  drawerTitle(
                      onTap: () {},
                      image: 'assets/icons/pro_logo_icon.png',
                      title: S.of(context).pro,
                      iconColor: Colors.orangeAccent),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'ver ' + version,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerTitle({
    required Function() onTap,
    IconData? iconData,
    String? image,
    Color? iconColor,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: iconColor ?? Theme.of(context).hintColor,
              ),
            if (image != null)
              Image.asset(
                image,
                width: 24,
                height: 24,
                color: iconColor ?? Theme.of(context).hintColor,
              ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pushPage(Widget page) async {
    setState(() {
      inOtherPage = true;
    });
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
    setState(() {
      inOtherPage = false;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (haveResult) return;
      if (multiMode) {
        if (multiScanList.indexWhere((element) => element.code == scanData.code) == -1) {
          Vibrate.vibrate();
          setState(() {
            multiScanList.add(scanData);
          });
        }
        return;
      }

      Vibrate.vibrate();

      final QRCodeDataType type = JudgeQrcodeDataType().judgeType(scanData.code ?? '');

      setState(() {
        controller.pauseCamera();
        haveResult = true;
      });
      final HistoryModel model = HistoryModel(
        createDate: DateTime.now(),
        qrcodeType: scanData.format.formatName,
        contentType: type.name,
        content: scanData.code ?? '',
        favorite: false,
      );
      final id = await HistoryDB.insertData(
        model,
      );
      model.id = id;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScannedPage(
            type: type,
            historyModel: model,
            onStateChange: () {},
          ),
        ),
      );
      setState(() {
        controller.resumeCamera();
        haveResult = false;
      });
    });
  }

  List<Barcode> _resultTransfer(List<dynamsoft_barcode.BarcodeResult> rawList) {
    List<Barcode> barcodeResults = [];
    for (final element in rawList) {
      BarcodeFormat format = BarcodeFormat.qrcode;
      switch (element.format) {
        case 'AZTEC':
          format = BarcodeFormat.aztec;
          break;
        case 'CODABAR':
          format = BarcodeFormat.codabar;
          break;
        case 'CODE_39':
          format = BarcodeFormat.code39;
          break;
        case 'CODE_93':
          format = BarcodeFormat.code93;
          break;
        case 'CODE_128':
          format = BarcodeFormat.code128;
          break;
        case 'DATAMATRIX':
          format = BarcodeFormat.dataMatrix;
          break;
        case 'EAN_8':
          format = BarcodeFormat.ean8;
          break;
        case 'EAN_13':
          format = BarcodeFormat.ean13;
          break;
        case 'ITF':
          format = BarcodeFormat.itf;
          break;
        case 'MAXICODE':
          format = BarcodeFormat.maxicode;
          break;
        case 'PDF417':
          format = BarcodeFormat.pdf417;
          break;
        case 'QR_CODE':
          format = BarcodeFormat.qrcode;
          break;
        // case BarcodeFormat.rss14:
        // //TODO 沒有這個類型
        //   return barcode_widget.Barcode.code128();
        // case BarcodeFormat.rssExpanded:
        // //TODO 沒有這個類型
        //   return barcode_widget.Barcode.code128();
        case 'UPC_A':
          format = BarcodeFormat.upcA;
          break;
        case 'UPC_E':
          format = BarcodeFormat.upcE;
          break;
        // case BarcodeFormat.upcEanExtension:
        // //TODO 沒有這個類型
        //   return barcode_widget.Barcode.upcE();
        // case BarcodeFormat.unknown:
        //   return barcode_widget.Barcode.qrCode();
      }
      barcodeResults.add(Barcode(element.text, format, []));
    }
    return barcodeResults;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
