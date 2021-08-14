import 'package:asking/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asking/auth/login/login_bloc.dart';
import 'package:asking/auth/login/login_event.dart';
import 'package:asking/auth/login/login_state.dart';
import 'package:asking/constants/color_constants.dart';

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
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: StyleConstants.regularInputDecoration(
            hintText: 'Enter you password'),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too weak',
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }
}
