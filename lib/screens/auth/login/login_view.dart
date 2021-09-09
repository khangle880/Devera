import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/constants/color_constants.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/login/login_bloc.dart';
import 'package:icon/screens/auth/login/login_event.dart';
import 'package:icon/screens/auth/login/login_state.dart';
import 'package:icon/widgets/custom_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _needLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(), authCubit: authCubit),
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
                  child: Text('Welcome Back!',
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
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h),
                            SizedBox(height: 20.h),
                            Text('Email',
                                style: GoogleFonts.titilliumWeb(
                                    color: Color(0xFFB5BBC9))),
                            SizedBox(
                                height: 30,
                                child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (email) {
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginEmailChanged(email: email));
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
                                      context.read<LoginBloc>().add(
                                          LoginPasswordChanged(
                                              password: password));
                                    },
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.black))),
                            SizedBox(height: 20.h),
                            if (_needLoading)
                              Center(child: CircularProgressIndicator()),
                            CustomTextButton(
                                buttonRadius: 50.r,
                                margin: EdgeInsets.symmetric(horizontal: 50.w),
                                text: "Login",
                                color: ColorConstants.kSecondaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    _needLoading = true;
                                  });
                                  context
                                      .read<LoginBloc>()
                                      .add(LoginSubmitted());
                                }),
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Don't have an Account?",
                                        style: TextStyle(color: Colors.black)),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                        onTap: () async {
                                          authCubit.showSignUp();
                                        },
                                        child: Text(
                                          'Sign Up',
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
