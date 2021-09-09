import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/constants/style_constants.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.textColor,
      this.outLineButton = false,
      this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      required this.onPressed,
      this.isLoading = false,
      this.buttonRadius = 5})
      : super(key: key);

  final String text;
  final Color color;
  final Color textColor;
  final bool isLoading;
  final bool outLineButton;
  final EdgeInsets margin;
  final VoidCallback onPressed;
  final double buttonRadius;

  @override
  _CustomTextButton createState() => _CustomTextButton();
}

class _CustomTextButton extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  late bool _isLoading;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    _isLoading = widget.isLoading;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.outLineButton ? Colors.transparent : widget.color,
            border: Border.all(color: widget.color, width: 2.0.w),
            borderRadius: BorderRadius.circular(widget.buttonRadius),
          ),
          margin: widget.margin,
          child: _isLoading
              ? const SizedBox(
                  height: 30.0, width: 30.0, child: CircularProgressIndicator())
              : Text(
                  widget.text,
                  style: StyleConstants.buttonTextStyle(widget.textColor),
                ),
        ),
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
