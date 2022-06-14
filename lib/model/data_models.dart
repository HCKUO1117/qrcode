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
      final title = GetContent.getContent(
        name: 'TITLE:',
        split: ';',
        rawString: rawString,
      );
      final url = GetContent.getContent(
        name: 'URL:',
        split: ';',
        rawString: rawString,
      );
      return UrlModel(url: url, title: title);
    }
    if (rawString.toUpperCase().startsWith('URL:')) {
      return UrlModel(
          url: GetContent.getContent(
            name: 'URL:',
            split: ';',
            rawString: rawString,
          ),
          title: '');
    }
    if (rawString.toUpperCase().startsWith('URLTO:')) {
      return UrlModel(
          url: GetContent.getContent(
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
      final to = GetContent.getContent(
        name: 'TO:',
        split: ';',
        rawString: rawString,
      );
      final sub = GetContent.getContent(
        name: 'SUB:',
        split: ';',
        rawString: rawString,
      );
      final body = GetContent.getContent(
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
    final to = GetContent.getContent(
      name: 'MAILTO:',
      split: '?',
      rawString: rawString,
    );
    final sub = GetContent.getContent(
      name: 'SUBJECT=',
      split: '&',
      rawString: rawString,
    );

    final ccRaw = GetContent.getContent(
      name: 'CC=',
      split: '&',
      rawString: rawString,
      useStartWith: true,
    );
    final cc = ccRaw.split(',');

    final bccRaw = GetContent.getContent(
      name: 'BCC=',
      split: '&',
      rawString: rawString,
    );
    final bcc = bccRaw.split(',');

    final body = GetContent.getContent(
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

class PhoneModel {
  String phoneNumber;

  PhoneModel({
    required this.phoneNumber,
  });

  factory PhoneModel.transfer(String rawString) {
    final phone = rawString.substring('TEL:'.length, rawString.length);
    return PhoneModel(
      phoneNumber: phone,
    );
  }
}

class SMSModel {
  String phoneNumber;
  String content;

  SMSModel({
    required this.phoneNumber,
    required this.content,
  });

  factory SMSModel.transfer(String rawString) {
    List<String> list = rawString.split(':');
    String phone = '';
    String content = '';
    if (list.length > 1) {
      phone = list[1];
    }
    if (list.length > 2) {
      content = list[2];
    }
    if (list.length > 3) {
      content = list[3];
    }
    return SMSModel(
      phoneNumber: phone,
      content: content,
    );
  }
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

  factory GEOModel.transfer(String rawString) {
    final location = GetContent.getContent(
      name: 'GEO:',
      split: '?',
      rawString: rawString,
    );
    final locationSplit = location.split(',');
    final lon = locationSplit[0];
    final lat = locationSplit[1];

    final name = GetContent.getContent(
      name: 'Q=',
      split: '&',
      rawString: rawString,
    );
    final zoom = GetContent.getContent(
      name: 'Z=',
      split: '&',
      rawString: rawString,
    );

    return GEOModel(
      lon: double.parse(lon),
      lat: double.parse(lat),
      name: name,
      zoom: double.parse(zoom),
    );
  }
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

  factory WifiModel.transfer(String rawString) {
    final type = GetContent.getContent(
      name: 'T:',
      split: ';',
      rawString: rawString,
    );
    final name = GetContent.getContent(
      name: 'S:',
      split: ';',
      rawString: rawString,
    );
    final password = GetContent.getContent(
      name: 'P:',
      split: ';',
      rawString: rawString,
    );

    return WifiModel(
      type: type,
      name: name,
      password: password,
    );
  }
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
