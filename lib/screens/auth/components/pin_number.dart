import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinNumber extends StatefulWidget {
  const PinNumber({
    Key? key,
    required this.textEditingController,
    required this.outlineInputBorder,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  @override
  _PinNumberState createState() => _PinNumberState();
}

class _PinNumberState extends State<PinNumber> {
  late TextEditingController controller;
  late bool isContainText;
  @override
  void initState() {
    controller = widget.textEditingController;
    isContainText = controller.text.isNotEmpty;
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        setState(() {
          isContainText = true;
        });
      } else {
        setState(() {
          isContainText = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.h,
      decoration: BoxDecoration(
          color: isContainText ? Color(0xFF75BF72) : Color(0xFF9EA5B1),
          borderRadius: BorderRadius.circular(30.r)),
    );
  }
}
