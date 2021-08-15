import 'package:asking/auth/confirm_resend_code/confirm_resend_code_bloc.dart';
import 'package:asking/auth/confirm_resend_code/confirm_resend_code_event.dart';
import 'package:asking/auth/confirm_resend_code/confirm_resend_code_state.dart';
import 'package:asking/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeField extends StatelessWidget {
  const CodeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmationResendCodeBloc, ConfirmationResendCodeState>(
        builder: (context, state) {
      return TextFormField(
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your code'),
        validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
        onChanged: (value) => context
            .read<ConfirmationResendCodeBloc>()
            .add(ConfirmationCodeChanged(code: value)),
      );
    });
  }
}
