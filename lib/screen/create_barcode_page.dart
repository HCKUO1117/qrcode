import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/widget/custom_dropdown_menu.dart';
import 'package:qrcode/screen/widget/custom_text_field.dart';
import 'package:qrcode/screen/widget/fake_text_field.dart';
import 'package:qrcode/screen/widget/my_banner_ad.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/utils.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;

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

  List<DropdownMenuItem<int>> dropDownList = [];

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

  int website = 0;
  TextEditingController websiteController = TextEditingController();

  int phone1 = 0;
  TextEditingController contactPhone1Controller = TextEditingController();
  int phone2 = 0;
  TextEditingController contactPhone2Controller = TextEditingController();
  int phone3 = 0;
  TextEditingController contactPhone3Controller = TextEditingController();

  int address1 = 0;
  TextEditingController contactStreet1Controller = TextEditingController();
  TextEditingController contactCity1Controller = TextEditingController();
  TextEditingController contactState1Controller = TextEditingController();
  TextEditingController contactPostal1Controller = TextEditingController();
  TextEditingController contactCounty1Controller = TextEditingController();
  int address2 = 0;
  TextEditingController contactStreet2Controller = TextEditingController();
  TextEditingController contactCity2Controller = TextEditingController();
  TextEditingController contactState2Controller = TextEditingController();
  TextEditingController contactPostal2Controller = TextEditingController();
  TextEditingController contactCounty2Controller = TextEditingController();

  TextEditingController contactNoteController = TextEditingController();

  ///bookmark
  TextEditingController bookmarkTitleController = TextEditingController();
  TextEditingController bookmarkUrlController = TextEditingController();

  ///calendar
  TextEditingController calendarTitleController = TextEditingController();
  TextEditingController calendarAddressController = TextEditingController();
  TextEditingController calendarNoteController = TextEditingController();

  bool allDay = false;

  String? errorText;

  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.type != BarcodeType.QrCode) {
        dropDownList = [
          DropdownMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(QRCodeDataType.values[0].icon),
                  const SizedBox(width: 16),
                  Text(QRCodeDataType.values[0].getText(context))
                ],
              ))
        ];
      } else {
        dropDownList = [
          for (int i = 0; i < QRCodeDataType.values.length; i++)
            DropdownMenuItem<int>(
              value: i,
              child: Row(
                children: [
                  Icon(QRCodeDataType.values[i].icon),
                  const SizedBox(width: 16),
                  Text(QRCodeDataType.values[i].getText(context))
                ],
              ),
            ),
        ];
      }
      setState(() {});
    });
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
    contactStreet1Controller.dispose();
    contactCity1Controller.dispose();
    contactState1Controller.dispose();
    contactPostal1Controller.dispose();
    contactCity1Controller.dispose();
    contactStreet2Controller.dispose();
    contactCity2Controller.dispose();
    contactState2Controller.dispose();
    contactPostal2Controller.dispose();
    contactCity2Controller.dispose();
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
                height: 50,
              ),
              const AdBanner(
                large: true,
              ),
              const SizedBox(
                height: 50,
              ),
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
            if (!Utils.correctFormat(textController.text, widget.type).correct) {
              Fluttertoast.showToast(msg: S.of(context).wrongFormat);
              return;
            }
            if (convertToQrcodeString().isEmpty) {
              Fluttertoast.showToast(msg: S.of(context).wrongFormat);
              return;
            }
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
              label: S.of(context).text,
              length: Utils.getFormatLength(widget.type),
              type: Utils.getFormatKeyBoardType(widget.type),
              onChange: (text) {
                final result = Utils.correctFormat(textController.text, widget.type);
                if (result.correct) {
                  setState(() {
                    errorText = null;
                  });
                } else {
                  if (result.errorChar == 'length') {
                    setState(() {
                      errorText = S.of(context).wrongLength;
                    });
                  } else {
                    setState(() {
                      errorText = S.of(context).wrongChar + ' : ${result.errorChar}';
                    });
                  }
                }
              },
              errorText: errorText,
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).allowedChar + ' : ' + Utils.allowChar(widget.type),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      case QRCodeDataType.url:
        return Column(
          children: [
            CustomTextField(
              controller: urlController,
              label: S.of(context).url,
            ),
          ],
        );
      case QRCodeDataType.mail:
        return Column(
          children: [
            CustomTextField(
              controller: emailController,
              label: S.of(context).email,
              type: TextInputType.emailAddress,
            ),
            CustomTextField(
              controller: emailSubjectController,
              label: S.of(context).subject,
            ),
            CustomTextField(
              controller: ccController,
              label: 'cc',
              type: TextInputType.emailAddress,
            ),
            CustomTextField(
              controller: bccController,
              label: 'bcc',
              type: TextInputType.emailAddress,
            ),
            CustomTextField(
              controller: emailBodyController,
              label: S.of(context).content,
            ),
          ],
        );
      case QRCodeDataType.phone:
        return Column(
          children: [
            CustomTextField(
              controller: phoneController,
              label: S.of(context).phone,
              type: TextInputType.phone,
            ),
          ],
        );
      case QRCodeDataType.sms:
        return Column(
          children: [
            CustomTextField(
              controller: smsPhoneController,
              label: S.of(context).phone,
              type: TextInputType.phone,
            ),
            CustomTextField(
              controller: smsBodyController,
              label: S.of(context).content,
            ),
          ],
        );
      case QRCodeDataType.geo:
        return Column(
          children: [
            CustomTextField(
              controller: geoNameController,
              label: S.of(context).name,
            ),
            // CustomTextField(
            //   controller: geoAddressController,
            //   label: 'geoAddress',
            // ),
            CustomTextField(
              controller: geoLatController,
              label: S.of(context).geoLat + '(-90~90)',
              type: TextInputType.number,
            ),
            CustomTextField(
              controller: geoLonController,
              label: S.of(context).geoLon + '(-180~180)',
              type: TextInputType.number,
            ),
          ],
        );
      case QRCodeDataType.wifi:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Text(S.of(context).type),
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
              value: wifiTypeValue,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: wifiNameController,
              label: S.of(context).name,
            ),
            CustomTextField(
              controller: wifiPasswordController,
              label: S.of(context).password,
            ),
          ],
        );
      case QRCodeDataType.contact:
        Contact();
        return Column(
          children: [
            Text(
              S.of(context).personalInfo,
              style: const TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              controller: displayNameController,
              label: S.of(context).displayName,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: firstNameController,
                    label: S.of(context).firstName,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: lastNameController,
                    label: S.of(context).lastName,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).organization,
              style: const TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              controller: companyNameController,
              label: S.of(context).organizationName,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: companyDepartmentController,
                    label: S.of(context).organizationDepartment,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: companyTitleController,
                    label: S.of(context).organizationTitle,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).email,
              style: const TextStyle(color: Colors.grey),
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
                    label: S.of(context).email,
                    type: TextInputType.emailAddress,
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
                    label: S.of(context).email,
                    type: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).website,
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                CustomDropDownMenu(
                  items: Utils.websiteTypeToList(WebsiteLabel.values),
                  expand: false,
                  onChange: (v) {
                    setState(() {
                      website = v!;
                    });
                  },
                  value: website,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: websiteController,
                    label: S.of(context).website,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).phone,
              style: const TextStyle(color: Colors.grey),
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
                    label: S.of(context).phone,
                    type: TextInputType.phone,
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
                    label: S.of(context).phone,
                    type: TextInputType.phone,
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
                    label: S.of(context).phone,
                    type: TextInputType.phone,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).address,
              style: const TextStyle(color: Colors.grey),
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
                    controller: contactStreet1Controller,
                    label: S.of(context).street,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: contactCity1Controller,
                    label: S.of(context).city,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactState1Controller,
                    label: S.of(context).state,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: contactPostal1Controller,
                    label: S.of(context).postal,
                    type: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactCounty1Controller,
                    label: S.of(context).country,
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
                    controller: contactStreet2Controller,
                    label: S.of(context).street,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: contactCity2Controller,
                    label: S.of(context).city,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactState2Controller,
                    label: S.of(context).state,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: contactPostal2Controller,
                    label: S.of(context).postal,
                    type: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: contactCounty2Controller,
                    label: S.of(context).country,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).note,
              style: const TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              controller: contactNoteController,
              label: S.of(context).note,
            ),
          ],
        );
      case QRCodeDataType.bookmark:
        return Column(
          children: [
            CustomTextField(
              controller: bookmarkTitleController,
              label: S.of(context).name,
            ),
            CustomTextField(
              controller: bookmarkUrlController,
              label: S.of(context).url,
            ),
          ],
        );
      case QRCodeDataType.calendar:
        return Column(
          children: [
            CustomTextField(
              controller: calendarTitleController,
              label: S.of(context).name,
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
                  Text(S.of(context).allDay),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('${S.of(context).start} : '),
            ),
            FakeTextField(
              haveValue: startTime != null,
              value: startTime != null
                  ? (allDay
                      ? DateFormat('yyyy-MM-dd').format(startTime!)
                      : DateFormat('yyyy-MM-dd HH:mm').format(startTime!))
                  : S.of(context).choose,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year + 100));
                startTime = date;
                if (!allDay && startTime != null) {
                  TimeOfDay? time =
                      await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    startTime = DateTime(
                        startTime!.year, startTime!.month, startTime!.day, time.hour, time.minute);
                  } else {
                    startTime = null;
                  }
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('${S.of(context).end} : '),
            ),
            FakeTextField(
              haveValue: endTime != null,
              value: endTime != null
                  ? (allDay
                      ? DateFormat('yyyy-MM-dd').format(endTime!)
                      : DateFormat('yyyy-MM-dd HH:mm').format(endTime!))
                  : S.of(context).choose,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year + 100));
                endTime = date;
                if (!allDay && endTime != null) {
                  TimeOfDay? time =
                      await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    endTime = DateTime(
                        endTime!.year, endTime!.month, endTime!.day, time.hour, time.minute);
                  } else {
                    endTime = null;
                  }
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: calendarAddressController,
              label: S.of(context).address,
            ),
            CustomTextField(
              controller: calendarNoteController,
              label: S.of(context).note,
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
        final Contact contact = Contact();
        contact.displayName = displayNameController.text;
        contact.name.first = firstNameController.text;
        contact.name.last = lastNameController.text;
        if (companyNameController.text.isNotEmpty ||
            companyDepartmentController.text.isNotEmpty ||
            companyTitleController.text.isNotEmpty) {
          contact.organizations.add(
            Organization(
                company: companyNameController.text,
                department: companyDepartmentController.text,
                title: companyTitleController.text),
          );
        }

        contact.emails.addAll([
          if (contactEmail1Controller.text.isNotEmpty)
            Email(contactEmail1Controller.text, label: EmailLabel.values[email1]),
          if (contactEmail2Controller.text.isNotEmpty)
            Email(contactEmail2Controller.text, label: EmailLabel.values[email2]),
        ]);
        if (websiteController.text.isNotEmpty) {
          contact.websites
              .add(Website(websiteController.text, label: WebsiteLabel.values[website]));
        }

        contact.phones.addAll([
          if (contactPhone1Controller.text.isNotEmpty)
            Phone(contactPhone1Controller.text, label: PhoneLabel.values[phone1]),
          if (contactPhone2Controller.text.isNotEmpty)
            Phone(contactPhone2Controller.text, label: PhoneLabel.values[phone2]),
          if (contactPhone3Controller.text.isNotEmpty)
            Phone(contactPhone3Controller.text, label: PhoneLabel.values[phone3]),
        ]);
        contact.addresses.addAll([
          if (contactStreet1Controller.text.isNotEmpty ||
              contactCity1Controller.text.isNotEmpty ||
              contactState1Controller.text.isNotEmpty ||
              contactPostal1Controller.text.isNotEmpty ||
              contactCounty1Controller.text.isNotEmpty)
            Address('',
                street: contactStreet1Controller.text,
                city: contactCity1Controller.text,
                state: contactState1Controller.text,
                postalCode: contactPostal1Controller.text,
                country: contactCounty1Controller.text,
                label: AddressLabel.values[address1]),
          if (contactStreet2Controller.text.isNotEmpty ||
              contactCity2Controller.text.isNotEmpty ||
              contactState2Controller.text.isNotEmpty ||
              contactPostal2Controller.text.isNotEmpty ||
              contactCounty2Controller.text.isNotEmpty)
            Address('',
                street: contactStreet2Controller.text,
                city: contactCity2Controller.text,
                state: contactState2Controller.text,
                postalCode: contactPostal2Controller.text,
                country: contactCounty2Controller.text,
                label: AddressLabel.values[address1]),
        ]);

        if (contactNoteController.text.isNotEmpty) {
          contact.notes.add(Note(contactNoteController.text));
        }

        return contact.toVCard();
      case QRCodeDataType.bookmark:
        StringBuffer result = StringBuffer();
        result.write('MEBKM:\nTITLE:');
        result.write(bookmarkTitleController.text);
        result.write(';\nURL:');
        result.write(bookmarkUrlController.text);
        result.write(';\n;');

        return result.toString();
      case QRCodeDataType.calendar:
        StringBuffer result = StringBuffer();
        result.write('BEGIN:VEVENT\nSUMMARY:');
        result.write(calendarTitleController.text);

        if (allDay) {
          if (startTime != null) {
            result.write('\nDTSTART;VALUE=DATE:');
            result.write(DateFormat('yyyyMMdd').format(startTime!));
          }
          if (endTime != null) {
            result.write('\nDTEND;VALUE=DATE:');
            result.write(DateFormat('yyyyMMdd').format(endTime!));
          }
        } else {
          if (startTime != null) {
            result.write('\nDTSTART;VALUE=DATE:');
            result.write(DateFormat('yyyyMMddTHHmmss').format(startTime!));
          }
          if (endTime != null) {
            result.write('\nDTEND;VALUE=DATE:');
            result.write(DateFormat('yyyyMMddTHHmmss').format(endTime!));
          }
        }
        result.write('\nLOCATION:');
        result.write(calendarAddressController.text);
        result.write('\nDESCRIPTION:');
        result.write(calendarNoteController.text);
        result.write('\nEND:VEVENT');

        return result.toString();
    }
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
