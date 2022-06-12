import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/action_type.dart';
import 'package:qrcode/model/data_models.dart';
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

    for (int i = 0; i < actions.length; i++) {
      actionList.add(actionButton(context, type: actions[i]));
    }
    notifyListeners();
  }

  void setInfoList(
    BuildContext context, {
    required QRCodeDataType type,
    required Barcode result,
  }) {
    switch (type) {
      case QRCodeDataType.text:
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('TEXT'),
          const SizedBox(height: 16),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.url:
        UrlModel urlModel = UrlModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('URL'),
          const SizedBox(height: 16),
          _contentTitle(
            icon: Icons.link,
            title: null,
            content: urlModel.url,
          ),
        ];
        break;
      case QRCodeDataType.mail:
        MailModel mailModel = MailModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('EMAIL'),
          const SizedBox(height: 16),
          _contentTitle(
            icon: Icons.mail_outline,
            title: null,
            content: mailModel.target,
            showAnyway: true,
          ),
          _contentTitle(
            icon: Icons.title,
            title: null,
            content: mailModel.title,
          ),
          _contentTitle(
            icon: null,
            title: 'CC',
            content: listToString(mailModel.cc),
          ),
          _contentTitle(
            icon: null,
            title: 'Bcc',
            content: listToString(mailModel.bcc),
          ),
          _contentTitle(
            icon: Icons.subject,
            title: null,
            content: mailModel.content,
          ),
        ];
        break;
      case QRCodeDataType.phone:
        //TODO
        infoList = [
          const Icon(Icons.phone_outlined),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.sms:
        //TODO
        infoList = [
          const Icon(Icons.sms_outlined),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.geo:
        //TODO
        infoList = [
          const Icon(Icons.location_on_outlined),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.wifi:
        //TODO
        infoList = [
          const Icon(Icons.wifi),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.contract:
        //TODO
        infoList = [
          const Icon(Icons.contact_mail_outlined),
          Text(result.code ?? ''),
        ];
        break;
      case QRCodeDataType.bookmark:
        UrlModel urlModel = UrlModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('BOOKMARK'),
          const SizedBox(height: 16),
          _contentTitle(
            icon: Icons.bookmark_border_outlined,
            title: null,
            content: urlModel.title,
          ),
          _contentTitle(
            icon: Icons.link,
            title: null,
            content: urlModel.url,
          ),
        ];
        break;
      case QRCodeDataType.calendar:
        //TODO
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
    IconData? iconData;
    switch (type) {
      case ActionType.launchApp:
        title = S.of(context).launch;
        iconData = Icons.launch;
        onTap = () {};
        break;
      case ActionType.copy:
        title = S.of(context).copy;
        iconData = Icons.copy;
        onTap = () {};
        break;
      case ActionType.search:
        title = S.of(context).search;
        iconData = Icons.search;
        onTap = () {};
        break;
      case ActionType.launchUrl:
        title = S.of(context).launchUrl;
        iconData = Icons.language;
        onTap = () {};
        break;
      case ActionType.saveBookmark:
        title = S.of(context).saveBookmark;
        iconData = Icons.bookmark_border_outlined;
        onTap = () {};
        break;
      case ActionType.sendEmail:
        title = S.of(context).sendEmail;
        iconData = Icons.email_outlined;
        onTap = () {};
        break;
      case ActionType.sendSms:
        title = S.of(context).sendSMS;
        iconData = Icons.sms_outlined;
        onTap = () {};
        break;
      case ActionType.call:
        title = S.of(context).call;
        iconData = Icons.phone_outlined;
        onTap = () {};
        break;
      case ActionType.openMap:
        title = S.of(context).openMap;
        iconData = Icons.location_on_outlined;
        onTap = () {};
        break;
      case ActionType.connectWifi:
        title = S.of(context).connectWifi;
        iconData = Icons.wifi;
        onTap = () {};
        break;
      case ActionType.saveContact:
        title = S.of(context).saveContact;
        iconData = Icons.contact_mail_outlined;
        onTap = () {};
        break;
      case ActionType.saveCalendar:
        title = S.of(context).saveCalendar;
        iconData = Icons.calendar_month_outlined;
        onTap = () {};
        break;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    );
  }

  String listToString(List<String> list) {
    String text = '';
    for (int i = 0; i < list.length; i++) {
      text += list[i];
      if (i != list.length - 1) {
        text += ',';
      }
    }
    return text;
  }

  Widget _typeText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _contentTitle({
    required IconData? icon,
    required String? title,
    required String content,
    IconData? actionIcon,
    Function()? action,
    bool showAnyway = false,
  }) {
    if (content.isEmpty && !showAnyway) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          const SizedBox(width: 8),
          SelectableText(content,strutStyle: const StrutStyle(
              forceStrutHeight: true, leading: 0.5),),
          const Spacer(),
          if (actionIcon != null)
            IconButton(
              onPressed: action,
              icon: Icon(actionIcon),
            ),
        ],
      ),
    );
  }
}
