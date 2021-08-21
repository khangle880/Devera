import 'package:asking/screens/auth/sign_up/sign_up_bloc.dart';
import 'package:asking/screens/auth/sign_up/sign_up_event.dart';
import 'package:asking/screens/auth/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/constants/style_constants.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
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
        obscureText: true,
        decoration: StyleConstants.regularInputDecoration(
            hintText: 'Enter your confirm password'),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too weak',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpConfirmPasswordChanged(confirmPassword: value)),
      );
    });
  }
}
