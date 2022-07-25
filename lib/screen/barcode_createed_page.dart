import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/random_string.dart';
import 'package:screenshot/screenshot.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;
import 'package:share_plus/share_plus.dart';

class BarcodeCreatedPage extends StatefulWidget {
  final BarcodeType barcodeType;
  final QRCodeDataType type;
  final HistoryModel historyModel;
  final VoidCallback onStateChange;

  const BarcodeCreatedPage({
    Key? key,
    required this.type,
    required this.historyModel,
    required this.onStateChange,
    required this.barcodeType,
  }) : super(key: key);

  @override
  State<BarcodeCreatedPage> createState() => _BarcodeCreatedPageState();
}

class _BarcodeCreatedPageState extends State<BarcodeCreatedPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    SelectableText(
                      widget.barcodeType.name,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Screenshot(
                        child: Builder(
                          builder: (context) {
                            final type = getType(widget.barcodeType);
                            return Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.white,
                              child: barcode_widget.BarcodeWidget(
                                data: widget.historyModel.content,
                                barcode: type,
                                errorBuilder: (context, e) {
                                  return Text(
                                    e,
                                    style: const TextStyle(color: Colors.red),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        controller: screenshotController),
                    const SizedBox(height: 16),
                    SelectableText(widget.historyModel.content),
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
      ),
    );
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

  barcode_widget.Barcode getType(barcode_widget.BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return barcode_widget.Barcode.itf16();
      case BarcodeType.CodeITF14:
        return barcode_widget.Barcode.itf14();
      case BarcodeType.CodeEAN13:
        return barcode_widget.Barcode.ean13();
      case BarcodeType.CodeEAN8:
        return barcode_widget.Barcode.ean8();
      case BarcodeType.CodeEAN5:
        return barcode_widget.Barcode.ean5();
      case BarcodeType.CodeEAN2:
        return barcode_widget.Barcode.ean2();
      case BarcodeType.CodeISBN:
        return barcode_widget.Barcode.isbn();
      case BarcodeType.Code39:
        return barcode_widget.Barcode.code39();
      case BarcodeType.Code93:
        return barcode_widget.Barcode.code93();
      case BarcodeType.CodeUPCA:
        return barcode_widget.Barcode.upcA();
      case BarcodeType.CodeUPCE:
        return barcode_widget.Barcode.upcE();
      case BarcodeType.Code128:
        return barcode_widget.Barcode.code128();
      case BarcodeType.GS128:
        return barcode_widget.Barcode.gs128();
      case BarcodeType.Telepen:
        return barcode_widget.Barcode.telepen();
      case BarcodeType.QrCode:
        return barcode_widget.Barcode.qrCode();
      case BarcodeType.Codabar:
        return barcode_widget.Barcode.codabar();
      case BarcodeType.PDF417:
        return barcode_widget.Barcode.pdf417();
      case BarcodeType.DataMatrix:
        return barcode_widget.Barcode.dataMatrix();
      case BarcodeType.Aztec:
        return barcode_widget.Barcode.aztec();
      case BarcodeType.Rm4scc:
        return barcode_widget.Barcode.rm4scc();
      case BarcodeType.Itf:
        return barcode_widget.Barcode.itf();
    }
  }
}
