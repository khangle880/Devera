import 'package:asking/auth/form_submission_status.dart';

class SignUpState {
  const SignUpState(
      {this.username = '',
      this.password = '',
      this.email = '',
      this.formStatus = const InitialFormStatus()});

  final String username;
  bool get isValidUsername => username.length > 3;

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  SignUpState copyWith(
      {String? username,
      String? password,
      String? email,
      FormSubmissionStatus? formStatus}) {
    return SignUpState(
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        formStatus: formStatus ?? this.formStatus);
  }
}
