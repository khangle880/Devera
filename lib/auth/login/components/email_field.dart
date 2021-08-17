import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/auth/login/login_bloc.dart';
import 'package:asking/auth/login/login_event.dart';
import 'package:asking/auth/login/login_state.dart';
import 'package:asking/constants/style_constants.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration:
            StyleConstants.regularInputDecoration(hintText: 'Enter your email'),
        validator: (value) => state.isValidEmail ? null : 'Email is not valid',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
      );
    });
  }
}
