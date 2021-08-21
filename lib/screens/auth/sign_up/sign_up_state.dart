import 'package:asking/screens/auth/form_submission_status.dart';

class SignUpState {
  const SignUpState(
      {this.password = '',
      this.confirmPassword = '',
      this.email = '',
      this.formStatus = const InitialFormStatus()});

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final String confirmPassword;
  bool get isValidConfirmPassword => confirmPassword.length > 6;

  final FormSubmissionStatus formStatus;

  SignUpState copyWith(
      {String? email,
      String? password,
      String? confirmPassword,
      FormSubmissionStatus? formStatus}) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formStatus: formStatus ?? this.formStatus);
  }
}
