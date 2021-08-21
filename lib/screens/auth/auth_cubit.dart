import 'package:asking/screens/auth/auth_credentials.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState {
  login,
  signUp,
  confirmSignUp,
  resendCode,
  confirmResendCode,
  forgotPassword,
  confirmForgotPasswordCode,
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.sessionCubit,
  }) : super(AuthState.login);

  final SessionCubit sessionCubit;

  AuthCredentials? credentials;

  void didPop() {
    credentials = null;
  }

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp(
      {required String username,
      required String email,
      required String password}) {
    credentials =
        AuthCredentials(username: username, email: email, password: password);
    emit(AuthState.confirmSignUp);
  }

  void showResendCode() {
    emit(AuthState.resendCode);
  }

  void showConfirmResendCode({required String username}) {
    credentials = AuthCredentials(username: username);
    emit(AuthState.confirmResendCode);
  }

  void showForgetPassword() {
    emit(AuthState.forgotPassword);
  }

  void showConfirmForgetPasswordCode({required String email}) {
    credentials = AuthCredentials(username: email);
    emit(AuthState.confirmForgotPasswordCode);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
