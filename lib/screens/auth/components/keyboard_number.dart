import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/constants/color_constants.dart';

class KeyBoardNumber extends StatelessWidget {
  const KeyBoardNumber({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  final int number;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.w,
        height: 60.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: ColorConstants.kGreyBackground),
        child: MaterialButton(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            focusElevation: 0.0,
            padding: EdgeInsets.all(8.0),
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
            height: 90.0,
            child: Text('$number',
                textAlign: TextAlign.center,
                style: GoogleFonts.titilliumWeb(
                  fontSize: 28.sp,
                  color: Color(0xFF003282),
                ))));
  }
}
