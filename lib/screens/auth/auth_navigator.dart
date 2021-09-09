import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/confirm_create_pin/confirm_create_pin_view.dart';
import 'package:icon/screens/auth/confirm_sign_up/confirm_sign_up_view.dart';
import 'package:icon/screens/auth/create_pin/create_pin_view.dart';
import 'package:icon/screens/auth/login/login_view.dart';
import 'package:icon/screens/auth/pin_security/pin_security_view.dart';
import 'package:icon/screens/auth/sign_up/sign_up_view.dart';
import 'package:icon/screens/auth/welcome/welcome_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        key: UniqueKey(),
        pages: [
          MaterialPage(child: WelcomeView()),
          if (state == AuthState.signUp ||
              state == AuthState.createPin ||
              state == AuthState.confirmPin ||
              state == AuthState.confirmSignUp) ...[
            //? SIGN UP VIEW
            MaterialPage(child: SignUpView()),
            if (state == AuthState.createPin ||
                state == AuthState.confirmPin ||
                state == AuthState.confirmSignUp) ...[
              //? CREATE PIN VIEW
              MaterialPage(child: CreatePinView()),
              if (state == AuthState.confirmPin ||
                  state == AuthState.confirmSignUp) ...[
                //? CONFIRM CREATE PIN
                MaterialPage(child: ConfirmCreatePinView()),
                if (state == AuthState.confirmSignUp) ...[
                  // ? CONFIRM SIGN UP
                  MaterialPage(child: ConfirmSignUpView())
                ]
              ]
            ]
          ],
          if (state == AuthState.login || state == AuthState.pinSecurity) ...[
            MaterialPage(child: LoginView()),
            if (state == AuthState.pinSecurity) ...[
              MaterialPage(child: PinSecurityView()),
            ]
          ]
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    });
  }
}
