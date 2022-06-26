import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AddContact{
  static const platform = MethodChannel('contact');

  static add(Map<String,dynamic> contact) async {
    try {
      final result = await platform.invokeMethod('add_contact', contact);
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }
}