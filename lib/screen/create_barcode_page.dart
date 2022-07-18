import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/widget/custom_dropdown_menu.dart';
import 'package:qrcode/screen/widget/custom_text_field.dart';

List<String> wifiType = ['WPA/WPA2 PSK', 'WEP', 'nopass'];

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

  int wifiTypeValue = 0;
  List<DropdownMenuItem<int>> wifiTypeList = [
    for (int i = 0; i < wifiType.length; i++)
      DropdownMenuItem<int>(
          value: i,
          child: Row(
            children: [Text(wifiType[i])],
          ))
  ];

  TextEditingController textController = TextEditingController();

  ///url
  TextEditingController urlController = TextEditingController();

  ///email
  TextEditingController emailController = TextEditingController();
  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();

  ///phone
  TextEditingController phoneController = TextEditingController();

  ///sms
  TextEditingController smsPhoneController = TextEditingController();
  TextEditingController smsBodyController = TextEditingController();

  ///geo
  TextEditingController geoNameController = TextEditingController();
  TextEditingController geoAddressController = TextEditingController();
  TextEditingController geoLatController = TextEditingController();
  TextEditingController geoLonController = TextEditingController();

  ///wifi
  TextEditingController wifiNameController = TextEditingController();
  TextEditingController wifiPasswordController = TextEditingController();

  ///contact
  TextEditingController displayNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();

    ///url
    urlController.dispose();

    ///email
    emailController.dispose();
    emailSubjectController.dispose();
    ccController.dispose();
    bccController.dispose();
    emailBodyController.dispose();

    ///phone
    phoneController.dispose();

    ///sms
    smsPhoneController.dispose();
    smsBodyController.dispose();

    ///geo
    geoNameController.dispose();
    geoAddressController.dispose();
    geoLatController.dispose();
    geoLonController.dispose();

    ///wifi
    wifiNameController.dispose();
    wifiPasswordController.dispose();

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
              qrcodeWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget qrcodeWidget() {
    switch (QRCodeDataType.values[dropDownValue]) {
      case QRCodeDataType.text:
        return Column(
          children: [
            CustomTextField(
              controller: textController,
              label: 'text',
            ),
          ],
        );
      case QRCodeDataType.url:
        return Column(
          children: [
            CustomTextField(
              controller: urlController,
              label: 'url',
            ),
          ],
        );
      case QRCodeDataType.mail:
        return Column(
          children: [
            CustomTextField(
              controller: emailController,
              label: 'email',
            ),
            CustomTextField(
              controller: emailController,
              label: 'subject',
            ),
            CustomTextField(
              controller: emailController,
              label: 'cc',
            ),
            CustomTextField(
              controller: emailController,
              label: 'bcc',
            ),
            CustomTextField(
              controller: emailController,
              label: 'body',
            ),
          ],
        );
      case QRCodeDataType.phone:
        return Column(
          children: [
            CustomTextField(
              controller: phoneController,
              label: 'phone',
            ),
          ],
        );
      case QRCodeDataType.sms:
        return Column(
          children: [
            CustomTextField(
              controller: smsPhoneController,
              label: 'smsPhone',
            ),
            CustomTextField(
              controller: smsBodyController,
              label: 'smsBody',
            ),
          ],
        );
      case QRCodeDataType.geo:
        return Column(
          children: [
            CustomTextField(
              controller: geoNameController,
              label: 'geoName',
            ),
            CustomTextField(
              controller: geoAddressController,
              label: 'geoAddress',
            ),
            CustomTextField(
              controller: geoLatController,
              label: 'geoLat',
            ),
            CustomTextField(
              controller: geoLonController,
              label: 'geoLon',
            ),
          ],
        );
      case QRCodeDataType.wifi:
        // TODO: Handle this case.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('type'),
            ),
            CustomDropDownMenu(
                expand: false,
                items: wifiType,
                onChange: (value) {
                  setState(
                    () {
                      wifiTypeValue = value!;
                    },
                  );
                },
                value: wifiTypeValue),
            CustomTextField(
              controller: wifiNameController,
              label: 'name',
            ),
            CustomTextField(
              controller: wifiPasswordController,
              label: 'password',
            ),
          ],
        );
      case QRCodeDataType.contact:
        Contact();
        return Column(
          children: [
            CustomTextField(
              controller: displayNameController,
              label: 'displayName',
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: firstNameController,
                    label: 'firstName',
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: lastNameController,
                    label: 'lastName',
                  ),
                ),
              ],
            )
          ],
        );
      case QRCodeDataType.bookmark:
        // TODO: Handle this case.
        return Column(
          children: [
            CustomTextField(
              controller: phoneController,
              label: 'phone',
            ),
          ],
        );
      case QRCodeDataType.calendar:
        // TODO: Handle this case.
        return Column(
          children: [
            CustomTextField(
              controller: phoneController,
              label: 'phone',
            ),
          ],
        );
    }
  }
}
