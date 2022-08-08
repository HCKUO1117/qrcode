import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

extension _BarcodeTypeEx on BarcodeType {
  String get title {
    switch (this) {
      case BarcodeType.CodeITF16:
        return 'ITF 16';
      case BarcodeType.CodeITF14:
        return 'ITF 14';
      case BarcodeType.CodeEAN13:
        return 'EAN 13';
      case BarcodeType.CodeEAN8:
        return 'EAN 8';
      case BarcodeType.CodeEAN5:
        return 'EAN 5';
      case BarcodeType.CodeEAN2:
        return 'EAN 2';
      case BarcodeType.CodeISBN:
        return 'ISBN';
      case BarcodeType.Code39:
        return 'CODE 39';
      case BarcodeType.Code93:
        return 'CODE 93';
      case BarcodeType.CodeUPCA:
        return 'UPC-A';
      case BarcodeType.CodeUPCE:
        return 'UPC-E';
      case BarcodeType.Code128:
        return 'CODE 128';
      case BarcodeType.GS128:
        return 'GS1 128';
      case BarcodeType.Telepen:
        return name;
      case BarcodeType.QrCode:
        return 'QR Code';
      case BarcodeType.Codabar:
        return 'CODABAR';
      case BarcodeType.PDF417:
        return 'PDF 417';
      case BarcodeType.DataMatrix:
        return 'Data Matrix';
      case BarcodeType.Aztec:
        return 'Aztec';
      case BarcodeType.Rm4scc:
        return 'RM4SCC';
      case BarcodeType.Itf:
        return 'ITF';
    }
  }

  List<bool> get support {
    switch (this) {
      case BarcodeType.CodeITF16:
        return [false, false, true];
      case BarcodeType.CodeITF14:
        return [false, false, true];
      case BarcodeType.CodeEAN13:
        return [true, true, true];
      case BarcodeType.CodeEAN8:
        return [true, true, true];
      case BarcodeType.CodeEAN5:
        return [false, false, true];
      case BarcodeType.CodeEAN2:
        return [false, false, true];
      case BarcodeType.CodeISBN:
        return [false, false, true];
      case BarcodeType.Code39:
        return [true, true, true];
      case BarcodeType.Code93:
        return [true, true, true];
      case BarcodeType.CodeUPCA:
        return [true, true, true];
      case BarcodeType.CodeUPCE:
        return [true, true, true];
      case BarcodeType.Code128:
        return [true, true, true];
      case BarcodeType.GS128:
        return [false, false, true];
      case BarcodeType.Telepen:
        return [false, false, true];
      case BarcodeType.QrCode:
        return [true, true, true];
      case BarcodeType.Codabar:
        return [true, true, true];
      case BarcodeType.PDF417:
        return [true, true, true];
      case BarcodeType.DataMatrix:
        return [true, true, true];
      case BarcodeType.Aztec:
        return [true, true, true];
      case BarcodeType.Rm4scc:
        return [false, false, true];
      case BarcodeType.Itf:
        return [false, true, true];
    }
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).info),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: ListView(
          children: [
            Text(
              S.of(context).supportType,
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
                3: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        S.of(context).type,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        S.of(context).fromPicture,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        S.of(context).fromCamera,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        S.of(context).generate,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Text(
                      'Dot Code',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: supportIcon(true),
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Text(
                      'RSS 14',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                    Container(
                      child: supportIcon(true),
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Text(
                      'RSS Expanded',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                    Container(
                      child: supportIcon(true),
                    ),
                    Container(
                      child: supportIcon(false),
                    ),
                  ],
                ),
                for (int i = 0; i < BarcodeType.values.length; i++)
                  TableRow(
                    children: <Widget>[
                      Text(
                        BarcodeType.values[i].title,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        child: supportIcon(BarcodeType.values[i].support[0]),
                      ),
                      Container(
                        child: supportIcon(BarcodeType.values[i].support[1]),
                      ),
                      Container(
                        child: supportIcon(BarcodeType.values[i].support[2]),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget supportIcon(bool support) {
    if (support) {
      return const Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.all(
        16,
      ),
      child: Icon(
        Icons.clear,
        color: Colors.redAccent,
      ),
    );
  }
}
