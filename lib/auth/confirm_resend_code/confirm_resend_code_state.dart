import 'package:asking/auth/form_submission_status.dart';

class ConfirmationResendCodeState {
  ConfirmationResendCodeState({
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String code;
  bool get isValidCode => code.length == 6;
  final FormSubmissionStatus formStatus;

  ConfirmationResendCodeState copyWith(
      {String? code, FormSubmissionStatus? formStatus}) {
    return ConfirmationResendCodeState(
        code: code ?? this.code, formStatus: formStatus ?? this.formStatus);
  }
}
