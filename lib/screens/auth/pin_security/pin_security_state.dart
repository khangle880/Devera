import 'package:icon/constants/form_submission_status.dart';

class PinSecurityState {
  PinSecurityState({
    this.formStatus = const InitialFormStatus(),
  });

  final FormSubmissionStatus formStatus;

  PinSecurityState copyWith({FormSubmissionStatus? formStatus}) {
    return PinSecurityState(formStatus: formStatus ?? this.formStatus);
  }
}
