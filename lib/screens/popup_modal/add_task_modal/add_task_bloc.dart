import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_event.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO I Should Create MultiBloc here

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskState(dueDate: DateTime.now())) {
    dataRepo
        .getCurrentUser()
        .then((user) => add(TaskAssigneeOnChanged(assignee: user)));
  }

  final AuthRepository authRepo = AuthRepository();
  final DataRepository dataRepo = DataRepository();

  List<String> memberAvatarUrls = [];
  List<String> memberIDs = [];

  @override
  Stream<AddTaskState> mapEventToState(AddTaskEvent event) async* {
    if (event is GetUsers) {
      final users = await dataRepo.getUsers();
      yield state.copyWith(users: users);
    } else if (event is SearchUsers) {
      // results = results.where((element) => element.name!.toLowerCase().contains((query.toLowerCase()))).toList();
      if (state.users != null && state.assigneeSearchString.isNotEmpty) {
        final searchUsers = state.users!
            .where((element) => element.username
                .toLowerCase()
                .contains(state.assigneeSearchString.toLowerCase()))
            .toList();
        yield state.copyWith(searchUsers: searchUsers);
      } else {
        yield state.copyWith(searchUsers: null);
      }
    } else if (event is AddMemberID) {
      if (!memberIDs.contains(event.memberID)) {
        memberIDs.add(event.memberID);
        print(memberIDs.length);
        print(memberIDs);
        yield state.copyWith(members: memberIDs);
      }
    } else if (event is AddMemberAvartarUrl) {
      if (!memberAvatarUrls.contains(event.memberAvatarUrl)) {
        memberAvatarUrls.add(event.memberAvatarUrl);
        yield state.copyWith(memberAvatarsUrl: memberAvatarUrls);
      }
      print(state.memberAvatarsUrl.length);
    } else if (event is TaskAssigneeSearchStringOnChanged) {
      yield state.copyWith(assigneeSearchString: event.assigneeSearchString);
    } else if (event is TaskProjectSearchStringOnChanged) {
      yield state.copyWith(projectSearchString: event.projectSearchString);
    } else if (event is TaskAssigneeOnChanged) {
      yield state.copyWith(assignee: event.assignee);
    } else if (event is TaskProjectOnChanged) {
      yield state.copyWith(project: event.project);
    } else if (event is TaskDueDateOnChanged) {
      yield state.copyWith(dueDate: event.dueDate);
    } else if (event is TaskDescriptionOnChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is CreateTask) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        if (state.description == null) {
          throw Exception("Description can't be empty");
        }

        final createdTask = await dataRepo.createTask(
            description: state.description ?? '',
            assignee: state.assignee!.id,
            project: 'Personal',
            dueDate: TemporalDate(state.dueDate != null
                ? DateTime(state.dueDate!.year, state.dueDate!.month,
                    state.dueDate!.day + 1)
                : DateTime.now()),
            members: state.members);
        print(createdTask);
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}
