import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Constants {
  //? Text's Styles
  static const regularHeader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularHintText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black38);

  static const boldHeading =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black);

  static buttonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: textColor);
  }
  //?----------------------------
}

//? Shortcut functions
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
//?------------------------------