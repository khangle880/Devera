import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeState { home, addTask, addNote, addCheckList }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.home);

  int totalCreatedTask = 0;
  int totalCompletedTask = 0;

  void showHome() => emit(HomeState.home);
  void showAddTask() => emit(HomeState.addTask);
  void showAddNote() {
    print('Hello again');
    emit(HomeState.addNote);
    print(state);
  }

  void showAddCheckList() => emit(HomeState.addCheckList);
}
