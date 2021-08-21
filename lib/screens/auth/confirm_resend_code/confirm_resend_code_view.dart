import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/screens/auth/confirm_resend_code/components/code_field.dart';
import 'package:asking/screens/auth/confirm_resend_code/confirm_resend_code_bloc.dart';
import 'package:asking/screens/auth/confirm_resend_code/confirm_resend_code_event.dart';
import 'package:asking/screens/auth/confirm_resend_code/confirm_resend_code_state.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmResendCodeView extends StatefulWidget {
  const ConfirmResendCodeView({Key? key}) : super(key: key);

  @override
  _ConfirmResendCodeViewState createState() => _ConfirmResendCodeViewState();
}

class _ConfirmResendCodeViewState extends State<ConfirmResendCodeView> {
  bool _needLoading = false;
  final _formKey = GlobalKey<FormState>();

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
          create: (context) => ConfirmationResendCodeBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>(),
          ),
          child: _confirmationForm(),
        ));
  }

  Widget _confirmationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Padding(
          padding: EdgeInsets.only(top: 30.0.h),
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
                            color: ColorConstants.kUnselectedLabelTextColor))),
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
      ),
    );
  }

  Widget _codeField() {
    return CodeField();
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationResendCodeBloc, ConfirmationResendCodeState>(
        builder: (context, state) {
      return CustomTextButton(
          text: 'Confirm',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: _needLoading,
          onPressed: () {
            setState(() {
              _needLoading = true;
            });
            if (_formKey.currentState!.validate()) {
              context
                  .read<ConfirmationResendCodeBloc>()
                  .add(ConfirmationSubmitted());
            }
          });
    });
  }
}
