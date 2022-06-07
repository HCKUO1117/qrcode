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


}