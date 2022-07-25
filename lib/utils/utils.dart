import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qrcode/model/check_format_model.dart';

class Utils {
  static String getBarcodeIcon(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return 'assets/barcode/ITF 16.png';
      case BarcodeType.CodeITF14:
        return 'assets/barcode/ITF 14.png';
      case BarcodeType.CodeEAN13:
        return 'assets/barcode/EAN 13.png';
      case BarcodeType.CodeEAN8:
        return 'assets/barcode/EAN 8.png';
      case BarcodeType.CodeEAN5:
        return 'assets/barcode/EAN 5.png';
      case BarcodeType.CodeEAN2:
        return 'assets/barcode/EAN 2.png';
      case BarcodeType.CodeISBN:
        return 'assets/barcode/ISBN.png';
      case BarcodeType.Code39:
        return 'assets/barcode/CODE 39.png';
      case BarcodeType.Code93:
        return 'assets/barcode/CODE 93.png';
      case BarcodeType.CodeUPCA:
        return 'assets/barcode/UPC A.png';
      case BarcodeType.CodeUPCE:
        return 'assets/barcode/UPC E.png';
      case BarcodeType.Code128:
        return 'assets/barcode/CODE 128.png';
      case BarcodeType.GS128:
        return 'assets/barcode/GS1 128.png';
      case BarcodeType.Telepen:
        return 'assets/barcode/Telepen.png';
      case BarcodeType.QrCode:
        return 'assets/barcode/QR-Code.png';
      case BarcodeType.Codabar:
        return 'assets/barcode/CODABAR.png';
      case BarcodeType.PDF417:
        return 'assets/barcode/PDF417.png';
      case BarcodeType.DataMatrix:
        return 'assets/barcode/Data Matrix.png';
      case BarcodeType.Aztec:
        return 'assets/barcode/Aztec.png';
      case BarcodeType.Rm4scc:
        return 'assets/barcode/RM4SCC.png';
      case BarcodeType.Itf:
        return 'assets/barcode/ITF.png';
    }
  }

  static String getBarcodeIntro(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return 'assets/barcode/ITF 16.png';
      case BarcodeType.CodeITF14:
        return 'assets/barcode/ITF 14.png';
      case BarcodeType.CodeEAN13:
        return 'assets/barcode/EAN 13.png';
      case BarcodeType.CodeEAN8:
        return 'assets/barcode/EAN 8.png';
      case BarcodeType.CodeEAN5:
        return 'assets/barcode/EAN 5.png';
      case BarcodeType.CodeEAN2:
        return 'assets/barcode/EAN 2.png';
      case BarcodeType.CodeISBN:
        return 'assets/barcode/ISBN.png';
      case BarcodeType.Code39:
        return 'assets/barcode/CODE 39.png';
      case BarcodeType.Code93:
        return 'assets/barcode/CODE 93.png';
      case BarcodeType.CodeUPCA:
        return 'assets/barcode/UPC A.png';
      case BarcodeType.CodeUPCE:
        return 'assets/barcode/UPC E.png';
      case BarcodeType.Code128:
        return 'assets/barcode/CODE 128.png';
      case BarcodeType.GS128:
        return 'assets/barcode/GS1 128.png';
      case BarcodeType.Telepen:
        return 'assets/barcode/Telepen.png';
      case BarcodeType.QrCode:
        return 'assets/barcode/QR-Code.png';
      case BarcodeType.Codabar:
        return 'assets/barcode/CODABAR.png';
      case BarcodeType.PDF417:
        return 'assets/barcode/PDF417.png';
      case BarcodeType.DataMatrix:
        return 'assets/barcode/Data Matrix.png';
      case BarcodeType.Aztec:
        return 'assets/barcode/Aztec.png';
      case BarcodeType.Rm4scc:
        return 'assets/barcode/RM4SCC.png';
      case BarcodeType.Itf:
        return 'assets/barcode/ITF.png';
    }
  }

  static bool getBarcodePro(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
      case BarcodeType.CodeITF14:
      case BarcodeType.CodeEAN8:
      case BarcodeType.CodeEAN5:
      case BarcodeType.CodeEAN2:
      case BarcodeType.CodeISBN:
      case BarcodeType.Code39:
      case BarcodeType.Code93:
      case BarcodeType.CodeUPCA:
      case BarcodeType.CodeUPCE:
      case BarcodeType.GS128:
      case BarcodeType.Telepen:
      case BarcodeType.Codabar:
      case BarcodeType.PDF417:
      case BarcodeType.DataMatrix:
      case BarcodeType.Aztec:
      case BarcodeType.Rm4scc:
      case BarcodeType.Itf:
        return true;
      case BarcodeType.Code128:
      case BarcodeType.QrCode:
      case BarcodeType.CodeEAN13:
        return false;
    }
  }

  static List<String> emailTypeToList(List<EmailLabel> list) {
    return [for (final element in list) element.name];
  }

  static List<String> websiteTypeToList(List<WebsiteLabel> list) {
    return [for (final element in list) element.name];
  }

  static List<String> phoneTypeToList(List<PhoneLabel> list) {
    return [for (final element in list) element.name];
  }

  static List<String> addressTypeToList(List<AddressLabel> list) {
    return [for (final element in list) element.name];
  }

  static CheckFormatModel correctFormat(String content, BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        // RegExp exp = RegExp(r'\d');
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 15,
        );
      case BarcodeType.CodeITF14:
        // RegExp exp = RegExp(r'\d');
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 13,
        );
      case BarcodeType.CodeEAN13:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 12,
        );
      case BarcodeType.CodeEAN8:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 7,
        );
      case BarcodeType.CodeEAN5:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 5,
        );
      case BarcodeType.CodeEAN2:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 2,
        );
      case BarcodeType.CodeISBN:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 12,
        );
      case BarcodeType.Code39:
        return formatChecker(
          rule: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-.\$/+% ',
          content: content,
        );
      case BarcodeType.Code93:
        return formatChecker(
          rule: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-.\$/+% ',
          content: content,
        );
      case BarcodeType.CodeUPCA:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 11,
        );
      case BarcodeType.CodeUPCE:
        return formatChecker(
          rule: '0123456789',
          content: content,
          length: 6,
        );
      case BarcodeType.Code128:
        return formatChecker(
          rule:
              '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~—',
          content: content,
        );
      case BarcodeType.GS128:
        return formatChecker(
          rule:
              '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~—',
          content: content,
        );
      case BarcodeType.Telepen:
        // RegExp exp = RegExp(
        //     r'[0-9a-zA-Z\s/\!/\"/\#/\$/\%/\&/\u0027/\(/\)/\*/\+/\,/\-/\./\//\:/\;/\</\=/\>/\?/\@/\[/\]/\\/\^/\_/\`/\{/\}/\|/\~/\—/]');

        //\Â/\Ô/\ü/\Ã/\È/\ð/\Ä/\É/\ñ/\Å/\Ê/\Æ/\Ë/\ó/\Ç/\Ì/\ô/\È/\Í/\õ/\É/\Î/\ö/\Ê/\Ï/\÷/\Ë/\Ð/\ø/\Ì/\Ñ/\ù/\Í/\Ò/\ú/\Î/\Ó/\û/
        return formatChecker(
          rule:
              '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~—',
          content: content,
        );
      case BarcodeType.QrCode:
        return CheckFormatModel(correct: true, errorChar: '');
      case BarcodeType.Codabar:
        return formatChecker(rule: '0123456789-.\$/+:', content: content);
      case BarcodeType.PDF417:
        return CheckFormatModel(correct: true, errorChar: '');
      case BarcodeType.DataMatrix:
        return CheckFormatModel(correct: true, errorChar: '');
      case BarcodeType.Aztec:
        return CheckFormatModel(correct: true, errorChar: '');
      case BarcodeType.Rm4scc:
        return formatChecker(
          rule: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          content: content,
        );
      case BarcodeType.Itf:
        return formatChecker(
          rule: '0123456789',
          content: content,
        );
    }
  }

  static int? getFormatLength(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return 15;
      case BarcodeType.CodeITF14:
        return 13;
      case BarcodeType.CodeEAN13:
        return 12;
      case BarcodeType.CodeEAN8:
        return 7;
      case BarcodeType.CodeEAN5:
        return 5;
      case BarcodeType.CodeEAN2:
        return 2;
      case BarcodeType.CodeISBN:
        return 12;
      case BarcodeType.Code39:
        return 1000;
      case BarcodeType.Code93:
        return 1000;
      case BarcodeType.CodeUPCA:
        return 11;
      case BarcodeType.CodeUPCE:
        return 6;
      case BarcodeType.Code128:
        return 1000;
      case BarcodeType.GS128:
        return 1000;
      case BarcodeType.Telepen:
        return 1000;
      case BarcodeType.QrCode:
        return null;
      case BarcodeType.Codabar:
        return 1000;
      case BarcodeType.PDF417:
        return 990;
      case BarcodeType.DataMatrix:
        return 1559;
      case BarcodeType.Aztec:
        return 2335;
      case BarcodeType.Rm4scc:
        return 1000;
      case BarcodeType.Itf:
        return 1000;
    }
  }

  static TextInputType? getFormatKeyBoardType(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return TextInputType.number;
      case BarcodeType.CodeITF14:
        return TextInputType.number;
      case BarcodeType.CodeEAN13:
        return TextInputType.number;
      case BarcodeType.CodeEAN8:
        return TextInputType.number;
      case BarcodeType.CodeEAN5:
        return TextInputType.number;
      case BarcodeType.CodeEAN2:
        return TextInputType.number;
      case BarcodeType.CodeISBN:
        return TextInputType.number;
      case BarcodeType.Code39:
        return null;
      case BarcodeType.Code93:
        return null;
      case BarcodeType.CodeUPCA:
        return TextInputType.number;
      case BarcodeType.CodeUPCE:
        return TextInputType.number;
      case BarcodeType.Code128:
        return null;
      case BarcodeType.GS128:
        return null;
      case BarcodeType.Telepen:
        return null;
      case BarcodeType.QrCode:
        return null;
      case BarcodeType.Codabar:
        return null;
      case BarcodeType.PDF417:
        return null;
      case BarcodeType.DataMatrix:
        return null;
      case BarcodeType.Aztec:
        return null;
      case BarcodeType.Rm4scc:
        return null;
      case BarcodeType.Itf:
        return TextInputType.number;
    }
  }

  static CheckFormatModel formatChecker({
    required String rule,
    required String content,
    int? length,
  }) {
    final roleList = rule.split('');
    final contentList = content.split('');

    for (var element in contentList) {
      if (!roleList.contains(element)) {
        return CheckFormatModel(
          correct: false,
          errorChar: element,
        );
      }
    }
    if (length != null && content.length != length) {
      return CheckFormatModel(
        correct: false,
        errorChar: 'length',
      );
    }
    return CheckFormatModel(
      correct: true,
      errorChar: '',
    );
  }
}
