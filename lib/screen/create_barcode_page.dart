import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/widget/custom_text_field.dart';

class CreateBarcodePage extends StatefulWidget {
  final bool isQrcode;

  const CreateBarcodePage({
    Key? key,
    required this.isQrcode,
  }) : super(key: key);

  @override
  State<CreateBarcodePage> createState() => _CreateBarcodePageState();
}

class _CreateBarcodePageState extends State<CreateBarcodePage> {
  int dropDownValue = 0;

  List<DropdownMenuItem<int>> dropDownList = [
    for (int i = 0; i < QRCodeDataType.values.length; i++)
      DropdownMenuItem<int>(
          value: i,
          child: Row(
            children: [
              Icon(QRCodeDataType.values[i].icon),
              const SizedBox(width: 16),
              Text(QRCodeDataType.values[i].name)
            ],
          ))
  ];

  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<int>(
                  underline: const SizedBox(),
                  value: dropDownValue,
                  items: dropDownList,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(
                      () {
                        dropDownValue = value!;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  S.of(context).content,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              CustomTextField(
                controller: textController,
                label: 'text',
              )
            ],
          ),
        ),
      ),
    );
  }
}
