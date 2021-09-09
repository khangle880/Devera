import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/constants/color_constants.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/sign_up/sign_up_bloc.dart';
import 'package:icon/screens/auth/sign_up/sign_up_event.dart';
import 'package:icon/screens/auth/sign_up/sign_up_state.dart';
import 'package:icon/widgets/custom_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (context) => SignUpBloc(
          authRepository: context.read<AuthRepository>(), authCubit: authCubit),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // this is new
        backgroundColor: ColorConstants.kGreyBackground,
        body: SafeArea(
          bottom: false,
          child: Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Text('Create Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold))),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(bottom: 200),
                  height: 200,
                  width: 300,
                  child: SvgPicture.asset(IconConstants.officeIcon)),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              // alignment: Alignment(1.0, -1.0),
              child: Container(
                  height: 430.h,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0.r),
                        topLeft: Radius.circular(15.0.r)),
                  ),
                  width: double.maxFinite,
                  child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h),
                            Text('First Name',
                                style: GoogleFonts.titilliumWeb(
                                    color: Color(0xFFB5BBC9))),
                            SizedBox(
                                height: 30,
                                child: TextFormField(
                                    onChanged: (firstName) {
                                      context.read<SignUpBloc>().add(
                                          SignUpFirstNameChanged(
                                              firstName: firstName));
                                    },
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.black))),
                            SizedBox(height: 20.h),
                            Text('Last Name',
                                style: GoogleFonts.titilliumWeb(
                                    color: Color(0xFFB5BBC9))),
                            SizedBox(
                                height: 30,
                                child: TextFormField(
                                    onChanged: (lastName) {
                                      context.read<SignUpBloc>().add(
                                          SignUpLastNameChanged(
                                              lastName: lastName));
                                    },
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.black))),
                            SizedBox(height: 20.h),
                            Text('Email',
                                style: GoogleFonts.titilliumWeb(
                                    color: Color(0xFFB5BBC9))),
                            SizedBox(
                                height: 30,
                                child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (email) {
                                      context.read<SignUpBloc>().add(
                                          SignUpEmailChanged(email: email));
                                    },
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.black))),
                            SizedBox(height: 20.h),
                            Text('Password',
                                style: GoogleFonts.titilliumWeb(
                                    color: Color(0xFFB5BBC9))),
                            SizedBox(
                                height: 30,
                                child: TextFormField(
                                    obscureText: true,
                                    onChanged: (password) {
                                      context.read<SignUpBloc>().add(
                                          SignUpPasswordChanged(
                                              password: password));
                                    },
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.black))),
                            SizedBox(height: 20.h),
                            CustomTextButton(
                                buttonRadius: 50.r,
                                margin: EdgeInsets.symmetric(horizontal: 50.w),
                                text: "Let's Get Started",
                                color: ColorConstants.kSecondaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  context
                                      .read<SignUpBloc>()
                                      .add(SignUpSubmitted());
                                }),
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Already have an account?",
                                        style: TextStyle(color: Colors.black)),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                        onTap: () {
                                          authCubit.showLogin();
                                        },
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ]),
                            )
                          ]);
                    },
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
