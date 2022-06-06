import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/model/qrcode_data_type.dart';

class ScannedPage extends StatefulWidget {
  final Barcode? result;
  final QRCodeDataType type;

  const ScannedPage({
    Key? key,
    required this.result, required this.type,
  }) : super(key: key);

  @override
  State<ScannedPage> createState() => _ScannedPageState();
}

class _ScannedPageState extends State<ScannedPage> {
  int selectIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    child: Icon(Icons.format_list_bulleted),
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
                    child: Icon(Icons.raw_on),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index){
                setState(() {
                  selectIndex = index;
                });
              },
              children: [
                Center(
                  child: (widget.result != null)
                      ? Text(
                      'Barcode Type: ${describeEnum(widget.result!.format)}   Data: ${widget.result!.code}')
                      : Text('Scan a code'),
                ),
                Center(
                  child: (widget.result != null)
                      ? Text(
                      'Barcode Type: ${describeEnum(widget.result!.format)}   Data: ${widget.result!.code}')
                      : Text('Scan a code'),
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
      pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
  }
}
