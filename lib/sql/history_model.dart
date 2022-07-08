class HistoryModel {
  int? id;
  DateTime createDate;
  String qrcodeType;
  String contentType;
  String content;
  bool favorite;

  HistoryModel({
    this.id,
    required this.createDate,
    required this.qrcodeType,
    required this.contentType,
    required this.content,
    required this.favorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'createDate': createDate.millisecondsSinceEpoch,
      'qrcodeType': qrcodeType,
      'contentType': contentType,
      'content': content,
      'favorite': favorite.toString(),
    };
  }

  @override
  String toString() {
    return 'id : $id\ncreateDate : $createDate \nqrcodeType : $qrcodeType\ncontentType : $contentType\ncontent : $content\nfavorite : $favorite';
  }
}
