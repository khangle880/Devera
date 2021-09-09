import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinNumber extends StatelessWidget {
  const PinNumber({
    Key? key,
    required this.textEditingController,
    required this.outlineInputBorder,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 45.w,
        child: TextField(
          controller: textEditingController,
          enabled: false,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16.0),
              border: outlineInputBorder,
              filled: true,
              fillColor: Colors.white),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.black),
        ));
  }
}
