import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/auth/sign_up/components/email_field.dart';
import 'package:asking/auth/sign_up/components/password_field.dart';
import 'package:asking/auth/sign_up/components/username_field.dart';
import 'package:asking/auth/sign_up/sign_up_bloc.dart';
import 'package:asking/auth/sign_up/sign_up_event.dart';
import 'package:asking/auth/sign_up/sign_up_state.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _needLoading = false;

  final _formKey = GlobalKey<FormState>();
  //? Focus node
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => SignUpBloc(
                authRepository: context.read<AuthRepository>(),
                authCubit: context.read<AuthCubit>()),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [_signUpForm(context)],
            )));
  }

  Widget _signUpForm(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
          setState(() {
            _needLoading = false;
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
                      Text('Welcome New User',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 12.h),
                      Text('Sign up to continue',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants
                                      .kUnselectedLabelTextColor))),
                      SizedBox(height: 48.h),
                      Text('Username',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _userNameField(),
                      SizedBox(height: 15.h),
                      Text('Email',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _emailField(),
                      SizedBox(height: 15.h),
                      Text('Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _passwordField(),
                      SizedBox(height: 30.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: _showSignInButton(context)),
                            Expanded(
                                flex: 2, child: _showSignUpButton(context)),
                          ]),
                    ]),
              ),
            )),
      ),
    );
  }

  Widget _userNameField() {
    return UserNameField(
        focusNode: _usernameFocusNode,
        onSubmitted: (value) {
          _usernameFocusNode.unfocus();
          ExtensionFunction.changeFocusFrom(context, _emailFocusNode);
        });
  }

  Widget _emailField() {
    return EmailField(
        focusNode: _emailFocusNode,
        onSubmitted: (value) {
          _emailFocusNode.unfocus();
          ExtensionFunction.changeFocusFrom(context, _passwordFocusNode);
        });
  }

  Widget _passwordField() {
    return PasswordField(
        focusNode: _passwordFocusNode,
        onSubmitted: (value) {
          _emailFocusNode.unfocus();
        });
  }

  Widget _showSignUpButton(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return CustomButton(
          text: 'Sign up',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });

            if (_formKey.currentState!.validate()) {
              context.read<SignUpBloc>().add(SignUpSubmitted());
            }

            setState(() {
              _needLoading = false;
            });
          });
    });
  }

  Widget _showSignInButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthCubit>().showLogin(),
        child: Text('Sign In',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kPrimaryDarkColor))));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
