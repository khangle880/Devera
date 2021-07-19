import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    this.outLineButton = false,
    this.marginVertical = 8.0,
    this.marginHorizontal = 24.0,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color textColor;
  final bool isLoading;
  final bool outLineButton;
  final double marginVertical;
  final double marginHorizontal;
  final VoidCallback onPressed;

  @override
  _CustomButton createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late bool _isLoading;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
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
    _isLoading = widget.isLoading;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.outLineButton ? Colors.transparent : widget.color,
            border: Border.all(color: widget.color, width: 2.0),
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          margin: EdgeInsets.symmetric(
              vertical: widget.marginVertical,
              horizontal: widget.marginHorizontal),
          child: _isLoading
              ? SizedBox(
                  height: 30.0, width: 30.0, child: CircularProgressIndicator())
              : Text(
                  widget.text,
                  style: Constants.buttonTextStyle(widget.textColor),
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
