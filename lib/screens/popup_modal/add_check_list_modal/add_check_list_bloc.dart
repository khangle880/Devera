import 'dart:async';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
part 'add_check_list_event.dart';
part 'add_check_list_state.dart';

class AddCheckListBloc extends Bloc<AddCheckListEvent, AddCheckListState> {
  AddCheckListBloc() : super(AddCheckListState());

  final AuthRepository authRepo = AuthRepository();
  final DataRepository dataRepo = DataRepository();

  @override
  Stream<AddCheckListState> mapEventToState(
    AddCheckListEvent event,
  ) async* {
    if (event is CheckListDescriptionOnChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is CheckListColorOnChanged) {
      yield state.copyWith(color: event.color);
    } else if (event is CheckListItemsOnChanged) {
      yield state.copyWith(listItems: event.listItems);
    } else if (event is CreateCheckList) {
      yield state.copyWith(formStatus: FormSubmitting());
      // print(state.listItems);
      try {
        if (state.description != null) {
          final userID = await authRepo.getUserIdFromAttributes();

          final checkList = await dataRepo.createCheckList(
              description: state.description ?? '',
              color: state.color,
              userID: userID);

          yield state.copyWith(formStatus: SubmissionSuccess());

          await dataRepo.createListItem(
              listItems: state.listItems, checkListID: checkList.id);
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
