import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/forgot_password/components/email_field.dart';
import 'package:asking/auth/forgot_password/forgot_password_bloc.dart';
import 'package:asking/auth/forgot_password/forgot_password_event.dart';
import 'package:asking/auth/forgot_password/forgot_password_state.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool _needLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.sp,
            ),
            onPressed: () {
              context.read<AuthCubit>().showLogin();
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: BlocProvider(
            create: (context) => ForgotPasswordBloc(
                authRepo: context.read<AuthRepository>(),
                authCubit: context.read<AuthCubit>()),
            child: _fogotPasswordForm()));
  }

  Widget _fogotPasswordForm() {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          setState(() {
            _needLoading = false;
          });
          ExtensionFunction.showSnackBar(
              context, formStatus.exception.toString());
        }
      },
      child: Form(
          child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Forgot Password',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kTextColor))),
                SizedBox(height: 12.h),
                Text('Please enter your email',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.kUnselectedLabelTextColor))),
                SizedBox(height: 30.h),
                Text('Email',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.kTextColor))),
                _emailField(),
                SizedBox(height: 40.h),
                _forgotPasswordButton()
              ]),
        ),
      )),
    );
  }

  Widget _emailField() {
    return EmailField();
  }

  Widget _forgotPasswordButton() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return CustomButton(
          text: 'Send Request',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });

            context.read<ForgotPasswordBloc>().add(FogotPasswordSubmitted());

            setState(() {
              _needLoading = false;
            });
          });
    });
  }
}
