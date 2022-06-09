import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/action_type.dart';
import 'package:qrcode/model/qrcode_data_type.dart';

class QRCodeProvider extends ChangeNotifier {

  Widget mainAction = const SizedBox();
  List<Widget> actionList = [];

  List<Widget> infoList = [];

  void setActionList(
    BuildContext context, {
    required QRCodeDataType type,
  }) {
    actionList.clear();
    List<ActionType> actions = [];
    notifyListeners();

    switch (type) {
      case QRCodeDataType.text:
        actions = [
          ActionType.launchApp,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.url:
        actions = [
          ActionType.launchUrl,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.mail:
        actions = [
          ActionType.sendEmail,
        ];
        break;
      case QRCodeDataType.phone:
        actions = [
          ActionType.call,
        ];
        break;
      case QRCodeDataType.sms:
        actions = [
          ActionType.sendSms,
        ];
        break;
      case QRCodeDataType.geo:
        actions = [
          ActionType.openMap,
        ];
        break;
      case QRCodeDataType.wifi:
        actions = [
          ActionType.connectWifi,
        ];
        break;
      case QRCodeDataType.contract:
        actions = [
          ActionType.saveContact,
          ActionType.call,
          ActionType.sendSms,
          ActionType.sendEmail,
          ActionType.openMap,
        ];
        break;
      case QRCodeDataType.bookmark:
        actions = [
          ActionType.saveBookmark,
          ActionType.launchUrl,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.calendar:
        actions = [
          ActionType.saveCalendar,
        ];
        break;
    }

    mainAction = actionButton(context, type: actions[0]);
    for (int i = 1;i < actions.length;i ++) {
      actionList.add(actionButton(context, type: actions[i]));
    }
    notifyListeners();
  }

  void setInfoList(
    BuildContext context, {
    required QRCodeDataType type,
        required Barcode result,
  }) {
    switch(type){
      case QRCodeDataType.text:
        infoList = [
          const SizedBox(height: 16),
          Row(children: const [
            Icon(Icons.abc,size: 60,),
            SizedBox(width: 8),
            Text('TEXT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ],),
          const SizedBox(height: 16),

          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.url:
        infoList = [
          const Icon(Icons.link),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.mail:
        infoList = [
          const Icon(Icons.email_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.phone:
        infoList = [
          const Icon(Icons.phone_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.sms:
        infoList = [
          const Icon(Icons.sms_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.geo:
        infoList = [
          const Icon(Icons.location_on_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.wifi:
        infoList = [
          const Icon(Icons.wifi),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.contract:
        infoList = [
          const Icon(Icons.contact_mail_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.bookmark:
        infoList = [
          const Icon(Icons.bookmark_border_outlined),
          Text(result.code ?? ''),

        ];
        break;
      case QRCodeDataType.calendar:
        infoList = [
          const Icon(Icons.calendar_month_outlined),
          Text(result.code ?? ''),

        ];
        break;
    }
    notifyListeners();
  }

  Widget actionButton(
    BuildContext context, {
    required ActionType type,
  }) {
    String title = '';
    Function() onTap = () {};
    switch (type) {
      case ActionType.launchApp:
        title = S.of(context).launch;
        onTap = () {};
        break;
      case ActionType.copy:
        title = S.of(context).copy;
        onTap = () {};
        break;
      case ActionType.search:
        title = S.of(context).search;
        onTap = () {};
        break;
      case ActionType.launchUrl:
        title = S.of(context).launchUrl;
        onTap = () {};
        break;
      case ActionType.saveBookmark:
        title = S.of(context).saveBookmark;
        onTap = () {};
        break;
      case ActionType.sendEmail:
        title = S.of(context).sendEmail;
        onTap = () {};
        break;
      case ActionType.sendSms:
        title = S.of(context).sendSMS;
        onTap = () {};
        break;
      case ActionType.call:
        title = S.of(context).call;
        onTap = () {};
        break;
      case ActionType.openMap:
        title = S.of(context).openMap;
        onTap = () {};
        break;
      case ActionType.connectWifi:
        title = S.of(context).connectWifi;
        onTap = () {};
        break;
      case ActionType.saveContact:
        title = S.of(context).saveContact;
        onTap = () {};
        break;
      case ActionType.saveCalendar:
        title = S.of(context).saveCalendar;
        onTap = () {};
        break;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(0.0),

        ),
      ),
      onPressed: onTap,
      child: Text(title,style: const TextStyle(color: Colors.black),),
    );
  }
}
