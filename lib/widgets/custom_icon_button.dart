import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/constants/color_constants.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    this.isSelected = false,
    this.buttonText = '',
  }) : super(key: key);

  final VoidCallback onPressed;
  final String iconPath;
  final bool isSelected;
  final String buttonText;

  @override
  _CustomIconButton createState() => _CustomIconButton();
}

class _CustomIconButton extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      upperBound: 0.5,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    bool textVisibility = false;

    if (widget.buttonText.isNotEmpty) {
      textVisibility = true;
    }

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
            padding: EdgeInsets.only(top: 7.h),
            width: 70.w,
            alignment: Alignment.center,
            child: Column(
              children: [
                SvgPicture.asset(
                  widget.iconPath,
                  width: 25.w,
                  height: 25.w,
                  color: Colors.grey,
                ),
                SizedBox(height: 7.h),
                Visibility(
                    visible: textVisibility,
                    child: Text(
                      widget.buttonText,
                      style: GoogleFonts.titilliumWeb(
                          color: Colors.grey, fontSize: 14.sp),
                    ))
              ],
            )),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
