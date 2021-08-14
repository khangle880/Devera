import 'package:asking/auth/sign_up/sign_up_bloc.dart';
import 'package:asking/auth/sign_up/sign_up_event.dart';
import 'package:asking/auth/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/constants/style_constants.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: StyleConstants.regularInputDecoration(
            hintText: 'Enter your password'),
        validator: (value) =>
            state.isValidUsername ? null : 'Password is too weak',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChange(password: value)),
      );
    });
  }
}
