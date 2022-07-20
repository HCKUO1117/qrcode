import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/widget/custom_dropdown_menu.dart';
import 'package:qrcode/screen/widget/custom_text_field.dart';
import 'package:qrcode/screen/widget/fake_text_field.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/utils.dart';

import 'barcode_createed_page.dart';

List<String> wifiType = ['WPA/WPA2 PSK', 'WEP', 'nopass'];

class CreateBarcodePage extends StatefulWidget {
  final BarcodeType type;

  const CreateBarcodePage({
    Key? key,
    required this.type,
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
        ),
      ),
  ];

  int wifiTypeValue = 0;

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
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDepartmentController = TextEditingController();
  TextEditingController companyTitleController = TextEditingController();

  int email1 = 0;
  TextEditingController contactEmail1Controller = TextEditingController();
  int email2 = 0;
  TextEditingController contactEmail2Controller = TextEditingController();

  TextEditingController websiteController = TextEditingController();

  int phone1 = 0;
  TextEditingController contactPhone1Controller = TextEditingController();
  int phone2 = 0;
  TextEditingController contactPhone2Controller = TextEditingController();
  int phone3 = 0;
  TextEditingController contactPhone3Controller = TextEditingController();

  int address1 = 0;
  TextEditingController contactAddress1Controller = TextEditingController();
  int address2 = 0;
  TextEditingController contactAddress2Controller = TextEditingController();

  TextEditingController contactNoteController = TextEditingController();

  ///bookmark
  TextEditingController bookmarkTitleController = TextEditingController();
  TextEditingController bookmarkUrlController = TextEditingController();

  ///calendar
  TextEditingController calendarTitleController = TextEditingController();
  TextEditingController calendarAddressController = TextEditingController();
  TextEditingController calendarNoteController = TextEditingController();

  bool allDay = false;

  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    if (widget.type != BarcodeType.QrCode) {
      dropDownList = [
        DropdownMenuItem<int>(
            value: 0,
            child: Row(
              children: [
                Icon(QRCodeDataType.values[0].icon),
                const SizedBox(width: 16),
                Text(QRCodeDataType.values[0].name)
              ],
            ))
      ];
    }
    super.initState();
  }

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

    ///contact
    displayNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    companyNameController.dispose();
    companyDepartmentController.dispose();
    companyTitleController.dispose();
    contactEmail1Controller.dispose();
    contactEmail2Controller.dispose();
    websiteController.dispose();
    contactPhone1Controller.dispose();
    contactPhone2Controller.dispose();
    contactPhone3Controller.dispose();
    contactAddress1Controller.dispose();
    contactAddress2Controller.dispose();
    contactNoteController.dispose();

    ///bookmark
    bookmarkTitleController.dispose();
    bookmarkUrlController.dispose();

    ///calendar
    calendarTitleController.dispose();
    calendarAddressController.dispose();
    calendarNoteController.dispose();

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
          title: Text(S.of(context).build + ' - ${widget.type.name}'),
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
              qrcodeWidget(),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          child: Container(
            color: Colors.teal,
            width: double.maxFinite,
            height: 50,
            child: Center(
              child: Text(
                S.of(context).build,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BarcodeCreatedPage(
                  type: QRCodeDataType.values[dropDownValue],
                  historyModel: HistoryModel(
                      createDate: DateTime.now(),
                      qrcodeType: widget.type.name,
                      contentType: QRCodeDataType.values[dropDownValue].name,
                      content: convertToQrcodeString(),
                      favorite: false),
                  onStateChange: () {},
                  barcodeType: widget.type,
                ),
              ),
            );
          },
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
              controller: emailSubjectController,
              label: 'subject',
            ),
            CustomTextField(
              controller: ccController,
              label: 'cc',
            ),
            CustomTextField(
              controller: bccController,
              label: 'bcc',
            ),
            CustomTextField(
              controller: emailBodyController,
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
            // CustomTextField(
            //   controller: geoAddressController,
            //   label: 'geoAddress',
            // ),
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
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
            const Text(
              'personal',
              style: TextStyle(color: Colors.grey),
            ),
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
            ),
            const Text(
              'company',
              style: TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              controller: companyNameController,
              label: 'companyName',
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: companyDepartmentController,
                    label: 'companyDepartment',
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: companyTitleController,
                    label: 'companyTitle',
                  ),
                ),
              ],
            ),
            const Text(
              'email',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.emailTypeToList(EmailLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      email1 = v!;
                    });
                  },
                  value: email1,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactEmail1Controller,
                    label: 'companyTitle',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.emailTypeToList(EmailLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      email2 = v!;
                    });
                  },
                  value: email2,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactEmail2Controller,
                    label: 'companyTitle',
                  ),
                ),
              ],
            ),
            const Text(
              'website',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.websiteTypeToList(WebsiteLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      email2 = v!;
                    });
                  },
                  value: email2,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: websiteController,
                    label: 'website',
                  ),
                ),
              ],
            ),
            const Text(
              'phone',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.phoneTypeToList(PhoneLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      phone1 = v!;
                    });
                  },
                  value: phone1,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactPhone1Controller,
                    label: 'phone',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.phoneTypeToList(PhoneLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      phone2 = v!;
                    });
                  },
                  value: phone2,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactPhone2Controller,
                    label: 'phone',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.phoneTypeToList(PhoneLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      phone3 = v!;
                    });
                  },
                  value: phone3,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactPhone3Controller,
                    label: 'phone',
                  ),
                ),
              ],
            ),
            const Text(
              'address',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.addressTypeToList(AddressLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      address1 = v!;
                    });
                  },
                  value: address1,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactAddress1Controller,
                    label: 'address',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.addressTypeToList(AddressLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      address2 = v!;
                    });
                  },
                  value: address2,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactAddress2Controller,
                    label: 'address',
                  ),
                ),
              ],
            ),
            const Text(
              'note',
              style: TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              controller: contactNoteController,
              label: 'note',
            ),
          ],
        );
      case QRCodeDataType.bookmark:
        return Column(
          children: [
            CustomTextField(
              controller: bookmarkTitleController,
              label: 'title',
            ),
            CustomTextField(
              controller: bookmarkUrlController,
              label: 'url',
            ),
          ],
        );
      case QRCodeDataType.calendar:
        // TODO: Handle this case.
        return Column(
          children: [
            CustomTextField(
              controller: calendarTitleController,
              label: 'title',
            ),
            InkWell(
              onTap: () {
                setState(() {
                  allDay = !allDay;
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: allDay,
                    onChanged: (v) {
                      setState(() {
                        allDay = v!;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('allday'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('start : '),
            ),
            FakeTextField(
              haveValue: false,
              onTap: () {
                print(123);
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('end : '),
            ),
            FakeTextField(
              haveValue: false,
              onTap: () {
                print(123);
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: calendarAddressController,
              label: 'address',
            ),
            CustomTextField(
              controller: calendarNoteController,
              label: 'note',
            ),
          ],
        );
    }
  }

  String convertToQrcodeString() {
    switch (QRCodeDataType.values[dropDownValue]) {
      case QRCodeDataType.text:
        return textController.text;
      case QRCodeDataType.url:
        return urlController.text;
      case QRCodeDataType.mail:
        StringBuffer result = StringBuffer();
        result.write('mailto:');
        result.write(emailController.text);
        result.write('?subject=');
        result.write(emailSubjectController.text);
        result.write('&cc=');
        result.write(ccController.text);
        result.write('&bcc=');
        result.write(bccController.text);
        result.write('&body=');
        result.write(emailBodyController.text);

        return result.toString();
      case QRCodeDataType.phone:
        StringBuffer result = StringBuffer();
        result.write('TEL:');
        result.write(phoneController.text);

        return result.toString();
      case QRCodeDataType.sms:
        StringBuffer result = StringBuffer();
        result.write('SMS:');
        result.write(smsPhoneController.text);
        result.write(':');
        result.write(smsBodyController.text);

        return result.toString();
      case QRCodeDataType.geo:
        StringBuffer result = StringBuffer();
        result.write('GEO:');
        result.write(geoLatController.text);
        result.write(',');
        result.write(geoLonController.text);
        result.write('?q=');
        result.write(geoNameController.text);

        return result.toString();
      case QRCodeDataType.wifi:
        StringBuffer result = StringBuffer();
        result.write('WIFI:\nT:');
        result.write(wifiTypeValue == 0 ? 'WPA' : wifiType[wifiTypeValue]);
        result.write(';\nS:');
        result.write(wifiNameController.text);
        result.write(';\nP:');
        result.write(wifiPasswordController.text);
        result.write(';\n;');

        return result.toString();
      case QRCodeDataType.contact:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.bookmark:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.calendar:
        // TODO: Handle this case.
        break;
    }
    return '';
  }
}
