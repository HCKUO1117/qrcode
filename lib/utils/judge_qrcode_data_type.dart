import 'package:qrcode/model/qrcode_data_type.dart';

class JudgeQrcodeDataType {
  QRCodeDataType judgeType(String data) {
    data = data.toUpperCase();
    if (data.startsWith('HTTP://') ||
        data.startsWith('HTTPS://') ||
        data.startsWith('URL:') ||
        data.startsWith('URL:') ||
        data.startsWith('FTP://')) {
      return QRCodeDataType.url;
    }
    if (data.startsWith('MEBKM:')) {
      return QRCodeDataType.bookmark;
    }
    if (data.startsWith('MATMSG:') || data.startsWith('MAILTO:')) {
      return QRCodeDataType.mail;
    }
    if (data.startsWith('TEL:')) {
      return QRCodeDataType.phone;
    }
    if (data.startsWith('SMSTO:') ||
        data.startsWith('SMS:') ||
        data.startsWith('MMSTO:') ||
        data.startsWith('MMS:')) {
      return QRCodeDataType.sms;
    }
    if (data.startsWith('GEO:')) {
      return QRCodeDataType.geo;
    }
    if (data.startsWith('WIFI:')) {
      return QRCodeDataType.wifi;
    }
    if (data.startsWith('BEGIN:VCARD') ||
        data.startsWith('MECARD:') ||
        data.startsWith('BIZCARD:')) {
      return QRCodeDataType.contract;
    }
    if (data.startsWith('BEGIN:VEVENT') ||
     data.startsWith('BEGIN:VCALENDAR')) {
      if(data.contains('BEGIN:VEVENT')){
        return QRCodeDataType.calendar;
      }
    }
    return QRCodeDataType.text;
  }
}
