import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/constants/color_constants.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/session/session_cubit.dart';
import 'package:icon/widgets/custom_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();
    return Scaffold(
        backgroundColor: ColorConstants.kSecondaryColor,
        body: SafeArea(
            child: Center(
          child: Column(children: [
            SizedBox(height: 50.h),
            SvgPicture.asset(IconConstants.logoIcon),
            SizedBox(height: 20.h),
            Text(
              'Welcome to',
              style: GoogleFonts.titilliumWeb(
                  color: Colors.white.withOpacity(0.504289), fontSize: 28.sp),
            ),
            Text(
              'WHOLLET',
              style: GoogleFonts.titilliumWeb(
                  color: Colors.white, fontSize: 40.sp),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextButton(
                    buttonRadius: 50.r,
                    margin: EdgeInsets.symmetric(horizontal: 70.w),
                    text: 'Sign In',
                    color: Colors.white,
                    textColor: ColorConstants.kSecondaryColor,
                    onPressed: () {
                      // context.read<SessionCubit>().signOut();
                      authCubit.showLogin();
                    }),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              margin: EdgeInsets.only(bottom: 40.h),
              width: 240,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10.w),
                    GestureDetector(
                        onTap: () {
                          print('Hello World');
                          authCubit.showSignUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ]),
            )
          ]),
        )));
  }
}
