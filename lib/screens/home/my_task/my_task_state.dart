import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:asking/models/ModelProvider.dart';

abstract class MyTaskState {}

class MyTaskLoading extends MyTaskState {}

class GetMyTaskSuccess extends MyTaskState {
  GetMyTaskSuccess({
    required this.myTask,
  });

  final Map<TemporalDate?, List<Task>> myTask;
}

class GetMyTaskFailed extends MyTaskState {
  GetMyTaskFailed({
    required this.exception,
  });

  final Exception exception;
}

class DeleteMyTaskSuccess extends MyTaskState {}

class DeleteMyTaskFailed extends MyTaskState {
  DeleteMyTaskFailed({
    required this.exception,
  });

  final Exception exception;
}

class UpdataMyTaskFailed extends MyTaskState {
  UpdataMyTaskFailed({
    required this.exception,
  });

  final Exception exception;
}
