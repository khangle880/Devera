import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/my_task/my_task_state.dart';

class MyTaskCubit extends Cubit<MyTaskState> {
  MyTaskCubit({
    required this.dataRepo,
    required this.user,
  }) : super(MyTaskLoading());

  final DataRepository dataRepo;
  final User user;

  void getMyTask() async {
    if (state is GetMyTaskSuccess == false) {
      emit(MyTaskLoading());
    }

    try {
      final myTask = await dataRepo.getMyTasks(userID: user.id);

      Map<TemporalDate?, List<Task>> groupByDay;

      groupByDay = groupBy(myTask, (Task task) {
        return task.dueDate;
      });

      emit(GetMyTaskSuccess(tasksByDay: groupByDay));
    } on Exception catch (e) {
      emit(GetMyTaskFailed(exception: e));
    }
  }

  void updateMyTask(Task currentMyTask) async {
    try {
      await dataRepo.updateMyTask(currentMyTask);
      // emit(UpdateMyTaskSuccess());
    } on Exception catch (e) {
      emit(GetMyTaskFailed(exception: e));
    }
  }

  void deleteMyTask(Task currentMyTask) async {
    try {
      await dataRepo.deleteMyTask(currentMyTask);
    } on Exception catch (e) {
      emit(GetMyTaskFailed(exception: e));
    }
  }

  void observeMyTasks() {
    final myTasksStream = dataRepo.observeMyTask();
    myTasksStream.listen((_) {
      getMyTask();
    });
  }
}
