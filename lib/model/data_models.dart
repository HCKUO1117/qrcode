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
  List<String> cc;
  List<String> bcc;
  String content;

  MailModel({
    required this.target,
    required this.title,
    required this.cc,
    required this.bcc,
    required this.content,
  });

  factory MailModel.transfer(String rawString) {
    if (rawString.toUpperCase().startsWith('MATMSG:')) {
      final to = GetContent().getContent(
        name: 'TO:',
        split: ';',
        rawString: rawString,
      );
      final sub = GetContent().getContent(
        name: 'SUB:',
        split: ';',
        rawString: rawString,
      );
      final body = GetContent().getContent(
        name: 'BODY:',
        split: ';',
        rawString: rawString,
      );

      return MailModel(
        target: to,
        title: sub,
        cc: [],
        bcc: [],
        content: body,
      );
    }
    final to = GetContent().getContent(
      name: 'MAILTO:',
      split: '?',
      rawString: rawString,
    );
    final sub = GetContent().getContent(
      name: 'SUBJECT=',
      split: '&',
      rawString: rawString,
    );

    final ccRaw = GetContent().getContent(
      name: 'CC=',
      split: '&',
      rawString: rawString,
      useStartWith: true,
    );
    final cc = ccRaw.split(',');

    final bccRaw = GetContent().getContent(
      name: 'BCC=',
      split: '&',
      rawString: rawString,
    );
    final bcc = bccRaw.split(',');

    final body = GetContent().getContent(
      name: 'BODY=',
      split: '&',
      rawString: rawString,
    );

    return MailModel(
      target: to,
      title: sub,
      cc: cc,
      bcc: bcc,
      content: body,
    );
  }
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
