import 'package:asking/screens/home/my_task/my_task_cubit.dart';
import 'package:asking/screens/home/my_task/my_task_state.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:asking/models/Task.dart';
import 'package:asking/screens/home/my_task/components/build_task_title.dart';

class SlidableTaskTile extends StatelessWidget {
  const SlidableTaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTaskCubit, MyTaskState>(
      builder: (context, state) {
        return Slidable(
          child: _buildTaskTile(task),
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1.0,
              ))),
              child: IconSlideAction(
                  foregroundColor: Colors.red,
                  color: Colors.white,
                  icon: Icons.edit,
                  onTap: () {
                    myTaskDetail(context, task);
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1.0,
              ))),
              child: IconSlideAction(
                  foregroundColor: Colors.red,
                  color: Colors.white,
                  icon: Icons.tram_sharp,
                  onTap: () {
                    BlocProvider.of<MyTaskCubit>(context).deleteMyTask(task);
                  }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskTile(Task task) => BuildTaskTile(
        task: task,
      );

  static myTaskDetail(BuildContext context, Task task) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return MyTaskDetailModalView(task: task);
        });
  }
}
