import 'package:asking/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleConstants {
  //? Text's Styles

  static TextStyle regularHeader = TextStyle(
      fontSize: 20.0.sp, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle regularDarkText = TextStyle(
      fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle regularBlurText = TextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w600,
      color: Color(0xFF9A9A9A).withOpacity(0.6));

  static TextStyle regularHintText = TextStyle(
      fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: Colors.black38);

  static TextStyle boldHeading = TextStyle(
      fontFamily: 'Varela',
      fontSize: 30.sp,
      fontWeight: FontWeight.w600,
      color: ColorConstants.kHeadingTextColor);

  static TextStyle buttonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: textColor);
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
