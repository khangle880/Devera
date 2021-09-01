import 'package:asking/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Lottie.asset(AnimationConstants.loadingAnimation,
                frameRate: FrameRate(60.0))));
  }
}
