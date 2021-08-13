import 'package:flutter/material.dart';

class ColorConstants {
  static const Color kPrimaryDarkColor = Color(0xFFF96060);
  static const Color kPrimaryLightColor = Color(0xFFF4F9F9);
  static const Color kSecondaryColor = Color(0xFFF4F9F9);

  static const Color kTextColor = Color(0xFF313131);
  static const Color kHeadingTextColor = Color(0xFF2C394B);
  static const Color kHightlightTextColor = Color(0xFF334257);
  static const Color kHightlightLabelTextColor = Color(0xFF43658B);
  static const Color kUnselectedLabelTextColor = Color(0xFF9B9B9B);

  static const Color kFavoriteIconColor = Color(0xFF334257);
  static const Color kBottomIconColor = Color(0xFF548CA8);

  static const Color kButtonColor = Color(0xFFF96060);
  static const Color kFloatingButtonColor = Color(0xFF7C83FD);

  static const LinearGradient kPrimaryGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFFFA53E), Color(0xFFFF7643)],
  );
}