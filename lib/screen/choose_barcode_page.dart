import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/screen/create_barcode_page.dart';
import 'package:qrcode/utils/utils.dart';

class ChooseBarcodePage extends StatefulWidget {
  const ChooseBarcodePage({Key? key}) : super(key: key);

  @override
  State<ChooseBarcodePage> createState() => _ChooseBarcodePageState();
}

class _ChooseBarcodePageState extends State<ChooseBarcodePage> {
  final typeList = <BarcodeType>[
    BarcodeType.QrCode,
    BarcodeType.Code128,
    BarcodeType.CodeEAN13,
  ];

  @override
  void initState() {
    for (var element in BarcodeType.values) {
      if (element != BarcodeType.QrCode &&
          element != BarcodeType.Code128 &&
          element != BarcodeType.CodeEAN13) {
        typeList.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).build),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                S.of(context).chooseType,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: typeList.length,
              itemBuilder: (context, index) {
                final type = typeList[index];
                return createQrcodeTitle(type);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget createQrcodeTitle(BarcodeType type) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color(0xffedf3ff),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateBarcodePage(
                type: type,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('info'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      Utils.getBarcodeIcon(type),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            if (Utils.getBarcodePro(type))
              Image.asset(
                'assets/icons/pro_logo_icon.png',
                color: Colors.orangeAccent,
                width: 20,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
