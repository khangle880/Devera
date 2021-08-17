import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/auth/login/components/password_field.dart';
import 'package:asking/auth/login/components/email_field.dart';
import 'package:asking/auth/login/login_bloc.dart';
import 'package:asking/auth/login/login_event.dart';
import 'package:asking/auth/login/login_state.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _needLoadingForLogin = false;
  bool _needLoadingForResendCode = false;

  //? Focus node
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => LoginBloc(
                  authRepo: context.read<AuthRepository>(),
                  authCubit: context.read<AuthCubit>(),
                ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [_loginForm(context)],
            )));
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
          setState(() {
            _needLoadingForLogin = false;
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Padding(
              padding: EdgeInsets.only(top: 118.0.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Welcome back',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 12.h),
                      Text('Sign in to continue',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants
                                      .kUnselectedLabelTextColor))),
                      SizedBox(height: 48.h),
                      Text('Email',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _emailField(),
                      SizedBox(height: 32.h),
                      Text('Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _passwordField(),
                      SizedBox(height: 15.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _showSignUpButton(context),
                            _showForgetPasswordButton(context)
                          ]),
                      SizedBox(height: 40.h),
                      _loginButton(),
                      SizedBox(height: 30.h),
                      _showResendCode(context),
                    ]),
              ),
            )),
      ),
    );
  }

  Widget _emailField() {
    return EmailField(
        focusNode: _usernameFocusNode,
        onSubmitted: (value) {
          _usernameFocusNode.unfocus();
          ExtensionFunction.changeFocusFrom(context, _passwordFocusNode);
        });
  }

  Widget _passwordField() {
    return PasswordField(
        focusNode: _passwordFocusNode,
        onSubmitted: (value) {
          _passwordFocusNode.unfocus();
        });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return CustomButton(
          text: 'Log In',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoadingForLogin,
          onPressed: () {
            setState(() {
              _needLoadingForLogin = true;
            });

            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginSubmitted());
            }

            setState(() {
              _needLoadingForLogin = false;
            });
          });
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthCubit>().showSignUp(),
        child: Text('Sign up',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kPrimaryDarkColor))));
  }

  Widget _showForgetPasswordButton(BuildContext context) {
    return SizedBox(
      child: TextButton(
          onPressed: () => context.read<AuthCubit>().showForgetPassword(),
          child: Text('Forgot password',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kTextColor)))),
    );
  }

  Widget _showResendCode(BuildContext context) {
    return CustomButton(
        text: 'Resend Confirmation Code',
        color: Colors.black,
        outLineButton: true,
        textColor: Colors.black,
        isLoading: _needLoadingForResendCode,
        onPressed: () {
          setState(() {
            _needLoadingForResendCode = true;
          });

          context.read<AuthCubit>().showResendCode();

          setState(() {
            _needLoadingForResendCode = false;
          });
        });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
