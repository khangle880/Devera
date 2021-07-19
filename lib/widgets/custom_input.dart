import 'package:flutter/material.dart';

import 'package:laptop/constants.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintText,
    this.hintTextStyle = Constants.regularHintText,
    this.textStyle = Constants.regularDarkText,
    this.marginVertical = 12.0,
    this.marginHorizontal = 24.0,
  }) : super(key: key);

  final String hintText;
  final TextStyle hintTextStyle;
  final TextStyle textStyle;
  final double marginVertical;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: hexToColor("#F2F2F2"),
          borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            hintStyle: hintTextStyle),
        style: Constants.regularDarkText,
      ),
    );
  }
}
