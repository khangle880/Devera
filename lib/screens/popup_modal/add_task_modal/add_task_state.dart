import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/models/ModelProvider.dart';

class AddTaskState {
  AddTaskState(
      {this.users,
      this.searchUsers,
      this.memberAvatarsUrl = const [],
      this.assigneeSearchString = '',
      this.projectSearchString = '',
      this.assignee,
      this.project,
      this.description,
      this.dueDate,
      this.members,
      this.formStatus = const InitialFormStatus()});

  final List<User>? users;
  final List<User>? searchUsers;
  final List<String> memberAvatarsUrl;
  final List<String>? members;
  final String assigneeSearchString;
  final String projectSearchString;
  final String? description;
  final String? project;
  final User? assignee;
  final DateTime? dueDate;

  FormSubmissionStatus formStatus;

  AddTaskState copyWith(
      {List<User>? users,
      List<User>? searchUsers,
      List<String>? memberAvatarsUrl,
      List<String>? members,
      String? assigneeSearchString,
      String? projectSearchString,
      String? project,
      String? description,
      User? assignee,
      DateTime? dueDate,
      FormSubmissionStatus? formStatus}) {
    return AddTaskState(
      users: users ?? this.users,
      searchUsers: searchUsers ?? this.searchUsers,
      memberAvatarsUrl: memberAvatarsUrl ?? this.memberAvatarsUrl,
      assigneeSearchString: assigneeSearchString ?? this.assigneeSearchString,
      projectSearchString: projectSearchString ?? this.projectSearchString,
      assignee: assignee ?? this.assignee,
      project: project ?? this.project,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      members: members ?? this.members,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
