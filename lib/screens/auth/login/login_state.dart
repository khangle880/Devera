import 'package:icon/constants/form_submission_status.dart';

class LoginState {
  const LoginState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  LoginState copyWith(
      {String? email, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
