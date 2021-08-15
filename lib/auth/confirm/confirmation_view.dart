import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/confirm/components/code_field.dart';
import 'package:asking/auth/confirm/confirmation_bloc.dart';
import 'package:asking/auth/confirm/confirmation_event.dart';
import 'package:asking/auth/confirm/confirmation_state.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({Key? key}) : super(key: key);

  @override
  _ConfirmationViewState createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  final _formKey = GlobalKey<FormState>();
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: BlocProvider(
            create: (context) => ConfirmationBloc(
                  authRepo: context.read<AuthRepository>(),
                  authCubit: context.read<AuthCubit>(),
                ),
            child: _confirmationForm()));
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding: EdgeInsets.only(top: 90.0.h),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Confirmation',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstants.kTextColor))),
                          SizedBox(height: 12.h),
                          Text('Please enter your code to confirm your account',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants
                                          .kUnselectedLabelTextColor))),
                          SizedBox(height: 20.h),
                          Text('Confirmation code',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.kTextColor))),
                          _codeField(),
                          SizedBox(height: 40.h),
                          _confirmButton()
                        ]),
                  ),
                ))));
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return CustomButton(
          text: 'Log In',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });
            if (_formKey.currentState!.validate()) {
              context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
            }
          });
    });
  }

  Widget _codeField() {
    return CodeField();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
