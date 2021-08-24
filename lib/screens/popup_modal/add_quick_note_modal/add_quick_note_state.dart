import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/auth/form_submission_status.dart';

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
    User? user,
    bool? isCurrentUser,
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
