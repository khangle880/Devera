import 'package:asking/auth/forgot_password/forgot_password_bloc.dart';
import 'package:asking/auth/forgot_password/forgot_password_event.dart';
import 'package:asking/auth/forgot_password/forgot_password_state.dart';
import 'package:asking/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return TextFormField(
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your email'),
        onChanged: (value) => context
            .read<ForgotPasswordBloc>()
            .add(ForgotPasswordEmailChanged(email: value)),
      );
    });
  }
}
