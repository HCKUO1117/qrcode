class UrlModel {
  String title;
  String url;

  UrlModel({
    required this.url,
    required this.title,
  });
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
