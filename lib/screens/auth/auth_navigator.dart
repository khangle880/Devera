import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/confirm_forgot_password/confirm_forgot_password_view.dart';
import 'package:asking/screens/auth/confirm_resend_code/confirm_resend_code_view.dart';
import 'package:asking/screens/auth/confirm_sign_up/confirmation_view.dart';
import 'package:asking/screens/auth/forgot_password/forgot_password_view.dart';
import 'package:asking/screens/auth/login/login_view.dart';
import 'package:asking/screens/auth/resend_code/resend_code_view.dart';
import 'package:asking/screens/auth/sign_up/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          // Show Sign up
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            MaterialPage(child: SignUpView()),

            // Show confirm sign up
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationView())
          ],
          // Show Forget Password
          if (state == AuthState.forgotPassword ||
              state == AuthState.confirmForgotPasswordCode) ...[
            MaterialPage(child: ForgotPasswordView()),

            // Show Confirm Forget Password
            if (state == AuthState.confirmForgotPasswordCode)
              MaterialPage(child: ConfirmForgotPasswordView())
          ]
        ],
        onPopPage: (route, result) {
          BlocProvider.of<AuthCubit>(context).didPop();
          return route.didPop(result);
        },
      );
    });
  }
}
