import 'package:asking/constants/form_submission_status.dart';

class ConfirmForgotPasswordState {
  ConfirmForgotPasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String password;
  bool get isValidPassword => password.length > 6;

  final String confirmPassword;
  bool get isValidConfirmPassword => confirmPassword.length > 6;

  final String code;
  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus formStatus;

  ConfirmForgotPasswordState copyWith(
      {String? password,
      String? confirmPassword,
      String? code,
      FormSubmissionStatus? formStatus}) {
    return ConfirmForgotPasswordState(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        code: code ?? this.code,
        formStatus: formStatus ?? this.formStatus);
  }
}
