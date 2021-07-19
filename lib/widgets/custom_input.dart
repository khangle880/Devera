import 'package:flutter/material.dart';

import 'package:laptop/constants.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintText,
    this.hintTextStyle = Constants.regularHintText,
    this.textStyle = Constants.regularDarkText,
    // this.marginVertical = 12.0,
    // this.marginHorizontal = 24.0,
    this.margin = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final String hintText;
  final TextStyle hintTextStyle;
  final TextStyle textStyle;
  final EdgeInsets margin;
  final TextInputType keyboardType;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: hexToColor("#F2F2F2"),
          borderRadius: BorderRadius.circular(12.0)),
      margin: margin,
      child: TextField(
        keyboardType: keyboardType,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
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
