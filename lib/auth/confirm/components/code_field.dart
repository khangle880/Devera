import 'package:asking/auth/confirm/confirmation_bloc.dart';
import 'package:asking/auth/confirm/confirmation_event.dart';
import 'package:asking/auth/confirm/confirmation_state.dart';
import 'package:asking/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeField extends StatelessWidget {
  const CodeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return TextFormField(
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your code'),
        validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
        onChanged: (value) => context
            .read<ConfirmationBloc>()
            .add(ConfirmationCodeChanged(code: value)),
      );
    });
  }
}
