import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/model/qrcode_data_type.dart';

class QRCodeProvider extends ChangeNotifier{
  List<Widget> actionList = [];

  void setActionList(QRCodeDataType type){
    switch(type){
      case QRCodeDataType.text:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.url:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.mail:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.phone:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.sms:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.geo:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.wifi:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.contract:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.bookmark:
        // TODO: Handle this case.
        break;
      case QRCodeDataType.calendar:
        // TODO: Handle this case.
        break;
    }
  }

  Widget actionButton(){
    return ElevatedButton(onPressed: (){}, child: Text(''));
  }
}