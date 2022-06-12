class GetContent {
  String getContent({
    required String name,
    required String split,
    required String rawString,
    bool useStartWith = false,
  }) {
    List<String> stringList = rawString.split(split);
    for (final element in stringList) {
      if (useStartWith) {
        if (element.toUpperCase().startsWith(name)) {
          final startIndex = element.toUpperCase().indexOf(name) + name.length;
          return element.substring(startIndex, element.length);
        }
      } else {
        if (element.toUpperCase().contains(name)) {
          final startIndex = element.toUpperCase().indexOf(name) + name.length;
          return element.substring(startIndex, element.length);
        }
      }
    }
    return '';
  }
}
