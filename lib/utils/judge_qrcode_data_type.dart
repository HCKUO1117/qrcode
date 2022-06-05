import 'package:qrcode/model/qrcode_data_type.dart';

class JudgeQrcodeDataType {
  QRCodeDataType judgeType(String data) {
    data.toUpperCase();
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
        data.startsWith('MMSTO:')) {
      return QRCodeDataType.sms;
    }
  }
}
