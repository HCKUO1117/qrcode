import 'package:qrcode/model/action_type.dart';

class Constants{
  List<ActionType> textActions = [
    ActionType.launchApp,
    ActionType.search,
  ];

  List<ActionType> urlActions = [
    ActionType.launchUrl,
    ActionType.search,
  ];

  ///ad
  static const bool testingMode = false;
  static const String testBannerId = 'ca-app-pub-3940256099942544/6300978111';
  static const String testInterstitialAdId = 'ca-app-pub-3940256099942544/1033173712';

  static const String bannerId = 'ca-app-pub-9063356592993842/6729044708';
  static const String interstitialAdId = 'ca-app-pub-9063356592993842/5189065466';

  ///string
  static const String notShowUrlSafety = 'notShowUrlSafety';
  static const String vibrate = 'vibrate';
  static const String pro = 'pro';

  ///feedback
  static const List<String> feedbackTypes = [
    'recommendation',
    'errorReport',
    'usageProblem',
    'other',
  ];
}