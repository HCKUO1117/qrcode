import 'package:qrcode/utils/get_content.dart';

class UrlModel {
  String title;
  String url;

  UrlModel({
    required this.url,
    required this.title,
  });

  factory UrlModel.transfer(String rawString) {
    if (rawString.toUpperCase().startsWith('MEBKM:')) {
      final title = GetContent().getContent(
        name: 'TITLE:',
        split: ';',
        rawString: rawString,
      );
      final url = GetContent().getContent(
        name: 'URL:',
        split: ';',
        rawString: rawString,
      );
      return UrlModel(url: url, title: title);
    }
    if (rawString.toUpperCase().startsWith('URL:')) {
      return UrlModel(
          url: GetContent().getContent(
            name: 'URL:',
            split: ';',
            rawString: rawString,
          ),
          title: '');
    }
    if (rawString.toUpperCase().startsWith('URLTO:')) {
      return UrlModel(
          url: GetContent().getContent(
            name: 'URLTO:',
            split: ';',
            rawString: rawString,
          ),
          title: '');
    }

    return UrlModel(url: rawString, title: '');
  }
}

class MailModel {
  String target;
  String title;
  String subtitle;
  List<String> cc;
  List<String> bc;
  String content;

  MailModel({
    required this.target,
    required this.title,
    required this.subtitle,
    required this.cc,
    required this.bc,
    required this.content,
  });
}

class SMSModel {
  String target;
  String content;

  SMSModel({
    required this.target,
    required this.content,
  });
}

class GEOModel {
  double lon;
  double lat;
  String name;
  double zoom;

  GEOModel({
    required this.lon,
    required this.lat,
    required this.name,
    required this.zoom,
  });
}

class WifiModel {
  String type;
  String name;
  String password;

  WifiModel({
    required this.type,
    required this.name,
    required this.password,
  });
}

class CalendarModel {
  String title;
  String startTime;
  String endTime;
  String location;
  String description;

  CalendarModel({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.description,
  });
}
