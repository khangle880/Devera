import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/screens/auth/resend_code/components/username_field.dart';
import 'package:asking/screens/auth/resend_code/resend_code_bloc.dart';
import 'package:asking/screens/auth/resend_code/resend_code_event.dart';
import 'package:asking/screens/auth/resend_code/resend_code_state.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResendCodeView extends StatefulWidget {
  const ResendCodeView({Key? key}) : super(key: key);

  @override
  _ResendCodeViewState createState() => _ResendCodeViewState();
}

class _ResendCodeViewState extends State<ResendCodeView> {
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
            create: (context) => ResendCodeBloc(
                authRepo: context.read<AuthRepository>(),
                authCubit: context.read<AuthCubit>()),
            child: _resendConfirmationForm()));
  }

  Widget _resendConfirmationForm() {
    return BlocListener<ResendCodeBloc, ResendCodeState>(
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
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text('Resend Code',
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
                                color:
                                    ColorConstants.kUnselectedLabelTextColor))),
                    SizedBox(height: 30.h),
                    Text('Username',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.kTextColor))),
                    _usernameField(),
                    SizedBox(height: 40.h),
                    _resendButton()
                  ])),
            ),
          ),
        ));
  }

  Widget _resendButton() {
    return BlocBuilder<ResendCodeBloc, ResendCodeState>(
        builder: (context, state) {
      return CustomTextButton(
          text: 'Resend',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });
            context.read<ResendCodeBloc>().add(ResendSubmitted());
          });
    });
  }

  Widget _usernameField() {
    return UserNameField();
  }
}
