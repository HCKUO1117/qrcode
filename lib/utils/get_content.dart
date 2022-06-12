class GetContent {
  String getContent({
    required String name,
    required String split,
    required String rawString,
  }) {
    List<String> stringList = rawString.split(split);
    for(final element in stringList){
      if(element.toUpperCase().contains(name)){
        final startIndex = element.indexOf(name) + name.length;
        return element.substring(startIndex,element.length);
      }
    }

    return '';
  }
}
