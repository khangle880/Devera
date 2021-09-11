import 'package:asking/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 150.0.h),
        child: Center(
          child: Column(children: [
            Lottie.asset(AnimationConstants.sorryAnimation,
                frameRate: FrameRate(60.0)),
            Text("I haven't created this view yet :<")
          ]),
        ),
      ),
    );
  }
}
