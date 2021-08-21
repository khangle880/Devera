import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_bloc.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_event.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/constants/style_constants.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    Key? key,
    required this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmForgotPasswordBloc, ConfirmForgotPasswordState>(
        builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your email'),
        validator: (value) =>
            state.isValidConfirmPassword ? null : 'Email is not valid',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) => context
            .read<ConfirmForgotPasswordBloc>()
            .add(ConfirmPasswordChanged(confirmPassword: value)),
      );
    });
  }
}
