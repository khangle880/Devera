import 'package:flutter/material.dart';

import 'package:laptop/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    this.outLineButton = false,
    this.marginVertical = 8.0,
    this.marginHorizontal = 24.0,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color textColor;
  final bool outLineButton;
  final double marginVertical;
  final double marginHorizontal;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: outLineButton ? Colors.transparent : color,
            border: Border.all(color: color, width: 2.0),
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          margin: EdgeInsets.symmetric(
              vertical: marginVertical, horizontal: marginHorizontal),
          child: Text(
            text,
            style: Constants.buttonTextStyle(textColor),
          )),
    );
  }
}
