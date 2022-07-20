import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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
}
