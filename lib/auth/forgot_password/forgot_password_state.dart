import 'package:asking/auth/form_submission_status.dart';

class ForgotPasswordState {
  ForgotPasswordState({
    this.email = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String email;
  final FormSubmissionStatus formStatus;

  ForgotPasswordState copyWith(
      {String? email, FormSubmissionStatus? formStatus}) {
    return ForgotPasswordState(
        email: email ?? this.email, formStatus: formStatus ?? this.formStatus);
  }
}
