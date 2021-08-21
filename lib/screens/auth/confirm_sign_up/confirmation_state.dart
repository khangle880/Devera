import 'package:asking/screens/auth/form_submission_status.dart';

class ConfirmationState {
  ConfirmationState({
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String code;
  bool get isValidCode => code.length == 6;
  final FormSubmissionStatus formStatus;

  ConfirmationState copyWith({String? code, FormSubmissionStatus? formStatus}) {
    return ConfirmationState(
        code: code ?? this.code, formStatus: formStatus ?? this.formStatus);
  }
}
