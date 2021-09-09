import 'package:icon/constants/form_submission_status.dart';

class ConfirmCreatePinState {
  ConfirmCreatePinState({
    this.formStatus = const InitialFormStatus(),
  });

  final FormSubmissionStatus formStatus;

  ConfirmCreatePinState copyWith({FormSubmissionStatus? formStatus}) {
    return ConfirmCreatePinState(formStatus: formStatus ?? this.formStatus);
  }
}
