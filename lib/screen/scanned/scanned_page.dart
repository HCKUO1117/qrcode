import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/provider/qrcode_provider.dart';
import 'package:qrcode/screen/widget/my_banner_ad.dart';
import 'package:qrcode/sql/history_db.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/random_string.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ScannedPage extends StatefulWidget {
  final QRCodeDataType type;
  final HistoryModel historyModel;
  final VoidCallback onStateChange;

  const ScannedPage({
    Key? key,
    required this.type,
    required this.historyModel,
    required this.onStateChange,
  }) : super(key: key);

  @override
  State<ScannedPage> createState() => _ScannedPageState();
}

class _ScannedPageState extends State<ScannedPage> {
  ScreenshotController screenshotController = ScreenshotController();

  int selectIndex = 0;

  PageController pageController = PageController();

  @override
  void initState() {
    final qrcodeProvider = Provider.of<QRCodeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      qrcodeProvider.setInfoList(
        context,
        type: widget.type,
        result: Barcode(widget.historyModel.content,
            BarcodeTypesExtension.fromString(widget.historyModel.qrcodeType), []),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final qrcodeProvider = Provider.of<QRCodeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (widget.historyModel.favorite) {
                widget.historyModel.favorite = false;
              } else {
                widget.historyModel.favorite = true;
              }
              await HistoryDB.updateData(widget.historyModel);
              print(await HistoryDB.displayAllData());
              setState(() {});
              widget.onStateChange.call();
            },
            icon: Icon(
              widget.historyModel.favorite ? Icons.star : Icons.star_border_outlined,
              color: widget.historyModel.favorite ? Colors.amberAccent : Colors.grey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setSelectIndex(0);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: selectIndex == 0
                        ? null
                        : const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Colors.white54,
                                spreadRadius: -3.0,
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                    child: const Icon(Icons.format_list_bulleted),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setSelectIndex(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: selectIndex == 1
                        ? null
                        : const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Colors.white54,
                                spreadRadius: -3.0,
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                    child: const Icon(Icons.raw_on),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
              children: [
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: qrcodeProvider.infoList,
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: qrcodeProvider.actionList,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            children: [
                              const SizedBox(height: 16),
                              SelectableText(
                                describeEnum(BarcodeTypesExtension.fromString(
                                    widget.historyModel.qrcodeType)),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Screenshot(
                                  child: Builder(
                                    builder: (context) {
                                      final type = getType(BarcodeTypesExtension.fromString(
                                          widget.historyModel.qrcodeType));
                                      return Container(
                                        padding: const EdgeInsets.all(16),
                                        color: Colors.white,
                                        child: barcode_widget.BarcodeWidget(
                                          data: widget.historyModel.content,
                                          barcode: type,
                                        ),
                                      );
                                    },
                                  ),
                                  controller: screenshotController),
                              const SizedBox(height: 16),
                              SelectableText(widget.historyModel.content),
                              const SizedBox(height: 50),
                              const AdBanner(large: true,),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: shareBarcodeInfo,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                )),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: const Icon(
                                  Icons.share,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: saveBarcodeToImage,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                )),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: const Icon(
                                  Icons.save_alt,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setSelectIndex(int index) {
    setState(() {
      selectIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  void saveBarcodeToImage() {
    try {
      screenshotController.capture().then((image) async {
        await ImageGallerySaver.saveImage(image!, name: 'qrcode${DateTime.now()}');
        Fluttertoast.showToast(msg: S.of(context).saveSuccess);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: S.of(context).saveError);
    }
  }

  void shareBarcodeInfo() {
    screenshotController.capture().then((image) async {
      final directory = await getApplicationDocumentsDirectory();
      String tempPath = directory.path;
      String fileName = RandomString().getRandomString(10);
      await File(tempPath + '/$fileName.png').writeAsBytes(image!);
      Share.shareFilesWithResult([tempPath + '/$fileName.png'], text: widget.historyModel.content);
    });
  }

  barcode_widget.Barcode getType(BarcodeFormat format) {
    switch (format) {
      case BarcodeFormat.aztec:
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
  }
}
