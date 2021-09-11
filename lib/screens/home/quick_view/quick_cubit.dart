import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/quick_view/quick_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickCubit extends Cubit<QuickState> {
  QuickCubit({
    required this.dataRepo,
    required this.user,
  }) : super(QuickNoteLoading());

  final DataRepository dataRepo;
  final User user;

  List<QuickNote> quickNotes = [];
  Map<CheckList, List<ListItem>> mapCheckLists = {};

  Future<void> getQuickNotes() async {
    if (state is GetQuickViewDataSuccess == false) {
      emit(QuickNoteLoading());
    }

    try {
      final getQuickNotes = await dataRepo.getQuickNote(userID: user.id);
      quickNotes = getQuickNotes;
      emit(GetQuickViewDataSuccess());
    } on Exception catch (e) {
      print(e);
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  void updateQuickNote(QuickNote updatedQuickNote) async {
    try {
      await dataRepo.updateQuickNote(updatedQuickNote);
    } on Exception catch (e) {
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  Future<void> deleteQuickNote(QuickNote quickNote) async {
    try {
      await dataRepo.deleteQuickNote(quickNote);
    } on Exception catch (e) {
      emit(GetQuickNoteFailed(exception: e));
    }
  }

  Future<void> getCheckLists() async {
    if (state is GetQuickViewDataSuccess == false) {
      emit(QuickNoteLoading());
    }

    try {
      final getCheckLists = await dataRepo.getCheckLists(userID: user.id);
      mapCheckLists = {};
      for (CheckList checkList in getCheckLists) {
        final List<ListItem> listItem =
            await dataRepo.getListItem(checkListID: checkList.id);
        mapCheckLists[checkList] = listItem;
      }

      emit(GetQuickViewDataSuccess());
    } on Exception catch (e) {
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  void updateCheckList(CheckList updatedCheckList) async {
    try {
      await dataRepo.updateCheckList(updatedCheckList);
    } on Exception catch (e) {
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  void updateListItem(ListItem updatedListItem) async {
    try {
      await dataRepo.updateListItem(updatedListItem);
      getCheckLists();
      // emit(UpdateMyTaskSuccess());
    } on Exception catch (e) {
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  void deleteCheckList(CheckList deletedCheckList) async {
    try {
      await dataRepo.deleteCheckList(deletedCheckList);
    } on Exception catch (e) {
      emit(GetQuickNoteFailed(exception: e));
    }
  }

  void deleteListItem(ListItem deletedListItem) async {
    try {
      await dataRepo.deleteListItem(deletedListItem);
      getCheckLists();
    } on Exception catch (e) {
      emit(GetQuickViewDataFailed(exception: e));
    }
  }

  void observeQuickNotes() {
    final quickNotesStream = dataRepo.observeQuickNotes();
    quickNotesStream.listen((_) => getQuickNotes());
  }

  void observeCheckLists() {
    final checkListStream = dataRepo.observeCheckList();
    checkListStream.listen((_) => getCheckLists());
  }

  void getQuickViewData() async {
    try {
      await getQuickNotes();
      await getCheckLists();
      emit(GetQuickViewDataSuccess());
    } on Exception catch (e) {
      print(e);
      emit(GetQuickViewDataFailed(
        exception: e,
      ));
    }
  }
}
