import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectWifi {
  static const platform = MethodChannel('wifi');
  static connect(Map<String, dynamic> config) async {
    try {
      final result = await platform.invokeMethod('connect', config);
      print(result);
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
