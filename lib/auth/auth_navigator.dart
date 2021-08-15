import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/confirm/confirmation_view.dart';
import 'package:asking/auth/confirm_resend_code/confirm_resend_code_view.dart';
import 'package:asking/auth/resend_code/resend_code_view.dart';
import 'package:asking/auth/sign_up/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/login_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      print(state);
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login ||
              state == AuthState.resendCode ||
              state == AuthState.confirmResendCode) ...[
            MaterialPage(child: LoginView()),
            // Show Resend Code
            if (state == AuthState.resendCode ||
                state == AuthState.confirmResendCode) ...[
              MaterialPage(child: ResendCodeView()),
              // Show Confirm resend code
              if (state == AuthState.confirmResendCode)
                MaterialPage(child: ConfirmResendCodeView())
            ]
          ],

          // Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            // Show Sign up
            MaterialPage(child: SignUpView()),

            // Show confirm sign up
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
