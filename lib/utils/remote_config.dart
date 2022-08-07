import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:qrcode/model/version_model.dart';

class RemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<VersionModel> getVersion() async {
    await remoteConfig.setDefaults(const {
      "version": '0.1.0',
      "force": false,
    });
    await remoteConfig.fetchAndActivate();

    return VersionModel(
      version: remoteConfig.getString('version'),
      force: remoteConfig.getBool('force'),
    );
  }
}
