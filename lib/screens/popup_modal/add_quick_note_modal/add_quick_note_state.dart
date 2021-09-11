import 'package:asking/constants/form_submission_status.dart';

class AddQuickNoteState {
  AddQuickNoteState({
    this.description,
    this.color = '#6074F9',
    this.formStatus = const InitialFormStatus(),
  });

  final String? description;
  final String color;

  FormSubmissionStatus formStatus;

  AddQuickNoteState copyWith({
    String? description,
    String? color,
    FormSubmissionStatus? formStatus,
  }) {
    return AddQuickNoteState(
      description: description ?? this.description,
      color: color ?? this.color,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
