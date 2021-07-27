import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:laptop/constants.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    this.isSelected = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String iconPath;
  final bool isSelected;

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

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
            height: 60,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: widget.isSelected
                  ? hexToColor("#EF7532")
                  : Colors.transparent,
              width: 2.0,
            ))),
            child: SvgPicture.asset(
              widget.iconPath,
              color: widget.isSelected ? hexToColor("#EF7532") : Colors.grey,
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
