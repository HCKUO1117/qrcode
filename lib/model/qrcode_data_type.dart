import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

enum QRCodeDataType {
  text,
  url,
  mail,
  phone,
  sms,
  geo,
  wifi,
  contact,
  bookmark,
  calendar,
}

extension QRCodeDataTypeEx on QRCodeDataType {
  IconData get icon {
    switch (this) {
      case QRCodeDataType.text:
        return Icons.short_text;
      case QRCodeDataType.url:
        return Icons.language;
      case QRCodeDataType.mail:
        return Icons.email_outlined;
      case QRCodeDataType.phone:
        return Icons.phone;
      case QRCodeDataType.sms:
        return Icons.sms_outlined;
      case QRCodeDataType.geo:
        return Icons.location_on_outlined;
      case QRCodeDataType.wifi:
        return Icons.wifi;
      case QRCodeDataType.contact:
        return Icons.contact_mail_outlined;
      case QRCodeDataType.bookmark:
        return Icons.bookmark_border_outlined;
      case QRCodeDataType.calendar:
        return Icons.calendar_month_outlined;
    }
  }

  String get name {
    switch (this) {
      case QRCodeDataType.text:
        return 'TEXT';
      case QRCodeDataType.url:
        return 'URL';
      case QRCodeDataType.mail:
        return 'EMAIL';
      case QRCodeDataType.phone:
        return 'PHONE';
      case QRCodeDataType.sms:
        return 'SMS';
      case QRCodeDataType.geo:
        return 'GEO';
      case QRCodeDataType.wifi:
        return 'WIFI';
      case QRCodeDataType.contact:
        return 'CONTACT';
      case QRCodeDataType.bookmark:
        return 'BOOKMARK';
      case QRCodeDataType.calendar:
        return 'CALENDAR';
    }
  }

  String getText(BuildContext context) {
    switch (this) {
      case QRCodeDataType.text:
        return S.of(context).text;
      case QRCodeDataType.url:
        return S.of(context).url;
      case QRCodeDataType.mail:
        return S.of(context).email;
      case QRCodeDataType.phone:
        return S.of(context).phone;
      case QRCodeDataType.sms:
        return S.of(context).sms;
      case QRCodeDataType.geo:
        return S.of(context).geo;
      case QRCodeDataType.wifi:
        return S.of(context).wifi;
      case QRCodeDataType.contact:
        return S.of(context).contact;
      case QRCodeDataType.bookmark:
        return S.of(context).bookmark;
      case QRCodeDataType.calendar:
        return S.of(context).calendar;
    }
  }
}
