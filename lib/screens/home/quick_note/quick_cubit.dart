import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/quick_note/quick_state.dart';

class QuickCubit extends Cubit<QuickState> {
  QuickCubit({
    required this.dataRepo,
    required this.user,
  }) : super(QuickNoteLoading());

  final DataRepository dataRepo;
  final User user;

  void getQuickNotes() async {
    if (state is GetQuickNoteSuccess == false) {
      emit(QuickNoteLoading());
    }

    try {
      final quickNotes = await dataRepo.getQuickNote(userID: user.id);
      print(quickNotes);
      emit(GetQuickNoteSuccess(quickNotes: quickNotes));
    } on Exception catch (e) {
      print(e);
      emit(GetQuickNoteFailed(exception: e));
    }
  }

  void observeTodo() {
    final todosStream = dataRepo.observeQuickNotes();
    todosStream.listen((_) => getQuickNotes());
  }
}
