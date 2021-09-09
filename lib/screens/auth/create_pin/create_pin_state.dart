import 'package:icon/constants/form_submission_status.dart';

class CreatePinState {
  CreatePinState({
    this.formStatus = const InitialFormStatus(),
  });

  final FormSubmissionStatus formStatus;

  CreatePinState copyWith({FormSubmissionStatus? formStatus}) {
    return CreatePinState(formStatus: formStatus ?? this.formStatus);
  }
}
