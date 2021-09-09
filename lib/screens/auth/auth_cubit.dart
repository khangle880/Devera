import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/screens/auth/auth_credentials.dart';
import 'package:icon/session/session_cubit.dart';

enum AuthState {
  welcome,
  login,
  pinSecurity,
  signUp,
  createPin,
  confirmPin,
  confirmSignUp,
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.sessionCubit,
  }) : super(AuthState.welcome);

  final SessionCubit sessionCubit;

  AuthCredentials? credentials;

  void didPop() {
    credentials = null;
  }

  void showWelcome() => emit(AuthState.welcome);
  void showLogin() => emit(AuthState.login);
  void showPinSecurity() => emit(AuthState.pinSecurity);
  void showSignUp() => emit(AuthState.signUp);
  void showCreatePin() {
    emit(AuthState.createPin);
  }

  void showConfirmPin() => emit(AuthState.confirmPin);
  void showConfirmSignUp() {
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
