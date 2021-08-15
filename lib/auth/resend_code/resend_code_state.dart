import 'package:asking/auth/form_submission_status.dart';

class ResendCodeState {
  ResendCodeState({
    this.username = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String username;
  final FormSubmissionStatus formStatus;

  ResendCodeState copyWith(
      {String? username, FormSubmissionStatus? formStatus}) {
    return ResendCodeState(
        username: username ?? this.username,
        formStatus: formStatus ?? this.formStatus);
  }
}
