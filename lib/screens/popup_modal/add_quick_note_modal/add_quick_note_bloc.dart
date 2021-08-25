import 'package:amplify_flutter/amplify.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/repositories/data_repository.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_event.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_state.dart';

class AddQuickNoteBloc extends Bloc<AddQuickNoteEvent, AddQuickNoteState> {
  AddQuickNoteBloc() : super(AddQuickNoteState());

  final AuthRepository authRepo = AuthRepository();
  final DataRepository dataRepo = DataRepository();

  @override
  Stream<AddQuickNoteState> mapEventToState(AddQuickNoteEvent event) async* {
    if (event is NoteDescriptionOnChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is NoteColorOnChanged) {
      yield state.copyWith(color: event.color);
    } else if (event is CreateNote) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        if (state.description != null) {
          final userID = await authRepo.getUserIdFromAttributes();

          final quickNote = await dataRepo.createQuickNote(
              description: state.description ?? '',
              color: state.color,
              userID: userID);

          print(quickNote);
        } else {
          throw Exception('Please write some text');
        }
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
