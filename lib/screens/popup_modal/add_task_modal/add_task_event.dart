import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:asking/models/ModelProvider.dart';

abstract class AddTaskEvent {}

class TaskAssigneeSearchStringOnChanged extends AddTaskEvent {
  TaskAssigneeSearchStringOnChanged({
    required this.assigneeSearchString,
  });

  final String assigneeSearchString;
}

class TaskAssigneeOnChanged extends AddTaskEvent {
  TaskAssigneeOnChanged({
    required this.assignee,
  });

  final User assignee;
}

class TaskProjectSearchStringOnChanged extends AddTaskEvent {
  TaskProjectSearchStringOnChanged({
    required this.projectSearchString,
  });

  final String projectSearchString;
}

class TaskDescriptionOnChanged extends AddTaskEvent {
  TaskDescriptionOnChanged({
    required this.description,
  });

  final String description;
}

class TaskProjectOnChanged extends AddTaskEvent {
  TaskProjectOnChanged({
    required this.project,
  });

  final String project;
}

class TaskDueDateOnChanged extends AddTaskEvent {
  TaskDueDateOnChanged({
    required this.dueDate,
  });

  final DateTime dueDate;
}

class AddMemberID extends AddTaskEvent {
  AddMemberID({
    required this.memberID,
  });

  final String memberID;
}

class AddMemberAvartarUrl extends AddTaskEvent {
  AddMemberAvartarUrl({
    required this.memberAvatarUrl,
  });

  final String memberAvatarUrl;
}

class GetUsers extends AddTaskEvent {}

class SearchUsers extends AddTaskEvent {}

class CreateTask extends AddTaskEvent {}
