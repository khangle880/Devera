import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/screens/auth/confirm_forgot_password/components/code_field.dart';
import 'package:asking/screens/auth/confirm_forgot_password/components/confirm_password_field.dart';
import 'package:asking/screens/auth/confirm_forgot_password/components/password_field.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_bloc.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_event.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_state.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmForgotPasswordView extends StatefulWidget {
  const ConfirmForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ConfirmForgotPasswordViewState createState() =>
      _ConfirmForgotPasswordViewState();
}

class _ConfirmForgotPasswordViewState extends State<ConfirmForgotPasswordView> {
  bool _needLoading = false;
  final _formKey = GlobalKey<FormState>();

  late FocusNode _confirmPasswordNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmCodeFocusNode;

  @override
  void initState() {
    _confirmCodeFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _confirmCodeFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

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
            context.read<AuthCubit>().showForgetPassword();
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
          create: (context) => ConfirmForgotPasswordBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: _confirmForgotPasswordForm()),
    );
  }

  Widget _confirmForgotPasswordForm() {
    return BlocListener<ConfirmForgotPasswordBloc, ConfirmForgotPasswordState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          ExtensionFunction.showSnackBar(
              context, formStatus.exception.toString());
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
              padding: EdgeInsets.only(top: 40.0.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Reset Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 12.h),
                      Text(
                          'Reset code was sent to your phone. Please enter the code and create new password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants
                                      .kUnselectedLabelTextColor))),
                      SizedBox(height: 40.h),
                      Text('Reset Code',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _confirmCodeField(),
                      SizedBox(height: 15.h),
                      Text('New Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _passwordField(),
                      SizedBox(height: 15.h),
                      Text('Confirm Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kTextColor))),
                      SizedBox(height: 15.h),
                      _confirmPasswordField(),
                      SizedBox(height: 40.h),
                      _showSignUpButton(context)
                    ]),
              ),
            )),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return ConfirmPasswordField(
        focusNode: _confirmPasswordNode,
        onSubmitted: (value) {
          _confirmPasswordNode.unfocus();
          ExtensionFunction.changeFocusFrom(context, _passwordFocusNode);
        });
  }

  Widget _passwordField() {
    return PasswordField(
        focusNode: _passwordFocusNode,
        onSubmitted: (value) {
          _passwordFocusNode.unfocus();
          ExtensionFunction.changeFocusFrom(context, _confirmCodeFocusNode);
        });
  }

  Widget _confirmCodeField() {
    return CodeField(
        focusNode: _confirmCodeFocusNode,
        onSubmitted: (value) {
          _confirmCodeFocusNode.unfocus();
        });
  }

  Widget _showSignUpButton(BuildContext context) {
    return BlocBuilder<ConfirmForgotPasswordBloc, ConfirmForgotPasswordState>(
        builder: (context, state) {
      return CustomTextButton(
          text: 'Sign up',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });

            if (_formKey.currentState!.validate()) {
              context
                  .read<ConfirmForgotPasswordBloc>()
                  .add(ConfirmationSubmitted());
            }

            setState(() {
              _needLoading = false;
            });
          });
    });
  }
}
