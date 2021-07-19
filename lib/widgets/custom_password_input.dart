import 'package:flutter/material.dart';

import 'package:laptop/constants.dart';

class CustomPasswordInput extends StatefulWidget {
  const CustomPasswordInput({
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
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _isObscure = true;
  IconData icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: hexToColor("#F2F2F2"),
          borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.symmetric(
          vertical: widget.marginVertical, horizontal: widget.marginHorizontal),
      child: TextField(
        obscureText: _isObscure,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(icon, color: Colors.black),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  icon = icon == Icons.visibility_off
                      ? Icons.visibility
                      : Icons.visibility_off;
                });
              },
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            hintStyle: widget.hintTextStyle),
        style: Constants.regularDarkText,
      ),
    );
  }
}
