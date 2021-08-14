import 'package:asking/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleConstants {
  //? Text's Styles

  static const TextStyle regularHeader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle regularDarkText = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle regularHintText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black38);

  static const TextStyle boldHeading = TextStyle(
      fontFamily: 'Varela',
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: ColorConstants.kHeadingTextColor);

  static TextStyle buttonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: textColor);
  }
  //?----------------------------

  //? InputDecoration's Styles

  static InputDecoration regularInputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16.sp),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorConstants.kPrimaryDarkColor),
      ),
    );
  }
  //?----------------------------
}
