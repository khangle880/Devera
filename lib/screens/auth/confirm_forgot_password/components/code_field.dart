import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_bloc.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_event.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/constants/style_constants.dart';

class CodeField extends StatelessWidget {
  const CodeField({
    Key? key,
    required this.focusNode,
    required this.onSubmitted,
  }) : super(key: key);

  final FocusNode focusNode;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmForgotPasswordBloc, ConfirmForgotPasswordState>(
        builder: (context, state) {
      return TextFormField(
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your code'),
        validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) => context
            .read<ConfirmForgotPasswordBloc>()
            .add(ConfirmationCodeChanged(code: value)),
      );
    });
  }
}
