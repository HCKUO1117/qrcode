import 'package:flutter_contacts/flutter_contacts.dart';

class GetContent {
  static String getContent({
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

  static String addressTransfer(Address address){
    String text = '';
    if(address.address.isNotEmpty){
      text += address.address;
    }
    if(address.street.isNotEmpty){
      text += ',' + address.street;
    }
    if(address.city.isNotEmpty){
      text += ',' + address.city;
    }
    if(address.state.isNotEmpty){
      text += ',' + address.state;
    }
    if(address.postalCode.isNotEmpty){
      text += ',' + address.postalCode;
    }
    if(address.country.isNotEmpty){
      text += ',' + address.country;
    }
    return text;
  }
}
