import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:asking/screens/home/home_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/my_task/my_task_state.dart';

class MyTaskCubit extends Cubit<MyTaskState> {
  MyTaskCubit(
      {required this.dataRepo, required this.user, required this.homeCubit})
      : super(MyTaskLoading());

  final DataRepository dataRepo;
  final User user;
  final HomeCubit homeCubit;

  Map<TemporalDate?, List<Task>> filterTaskAll = {};
  Map<TemporalDate?, List<Task>> filterTaskUnComplete = {};
  Map<TemporalDate?, List<Task>> filterTaskCompleted = {};

  void filterTaskByCompleted(List<Task> myTasks) {
    final filterTask = myTasks.where((task) => task.isComplete).toList();

    final groupByCompleted = groupBy(filterTask, (Task task) {
      return task.dueDate;
    });

    filterTaskCompleted = groupByCompleted;

    homeCubit.totalCompletedTask = filterTask.length;
    print(homeCubit.totalCreatedTask);
  }

  void getTasksByCompleted() {
    print('Hello World');
    emit(GetMyTaskSuccess(myTask: filterTaskCompleted));
  }

  void filterTaskByUnCompleted(List<Task> myTasks) {
    final filterTask = myTasks.where((task) => !task.isComplete).toList();

    final groupByUnCompleted = groupBy(filterTask, (Task task) {
      return task.dueDate;
    });

    filterTaskUnComplete = groupByUnCompleted;
  }

  void getTasksByUnComplete() {
    emit(GetMyTaskSuccess(myTask: filterTaskUnComplete));
  }

  void getTasksAll() {
    emit(GetMyTaskSuccess(myTask: filterTaskAll));
  }

  void getMyTask() async {
    if (state is GetMyTaskSuccess == false) {
      emit(MyTaskLoading());
    }

    try {
      List<Task> myTask = await dataRepo.getMyTasks(userID: user.id);

      Map<TemporalDate?, List<Task>> groupByDay;

      groupByDay = groupBy(myTask, (Task task) {
        return task.dueDate;
      });

      filterTaskAll = groupByDay;

      emit(GetMyTaskSuccess(myTask: filterTaskAll));

      homeCubit.totalCreatedTask = myTask.length;

      filterTaskByCompleted(myTask);
      filterTaskByUnCompleted(myTask);
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
