import 'package:asking/screens/auth/resend_code/resend_code_bloc.dart';
import 'package:asking/screens/auth/resend_code/resend_code_event.dart';
import 'package:asking/screens/auth/resend_code/resend_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/constants/style_constants.dart';

class UserNameField extends StatelessWidget {
  const UserNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResendCodeBloc, ResendCodeState>(
        builder: (context, state) {
      return TextFormField(
        decoration: StyleConstants.regularInputDecoration(
            hintText: 'Enter your username'),
        onChanged: (value) => context
            .read<ResendCodeBloc>()
            .add(ResendCodeUserNameChanged(username: value)),
      );
    });
  }
}
