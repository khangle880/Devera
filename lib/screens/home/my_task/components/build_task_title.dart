import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/models/Task.dart';
import 'package:asking/screens/home/my_task/my_task_cubit.dart';
import 'package:asking/screens/home/my_task/my_task_state.dart';

class BuildTaskTile extends StatefulWidget {
  const BuildTaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  _BuildTaskTileState createState() => _BuildTaskTileState();
}

class _BuildTaskTileState extends State<BuildTaskTile> {
  @override
  Widget build(BuildContext context) {
    Task _task = widget.task;

    return BlocBuilder<MyTaskCubit, MyTaskState>(builder: (context, state) {
      return Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: GestureDetector(
                    onTap: () {
                      if (widget.task.isComplete) {
                        setState(() {
                          _task = _task.copyWith(isComplete: false);
                        });
                      } else {
                        setState(() {
                          _task = _task.copyWith(isComplete: true);
                        });
                      }

                      BlocProvider.of<MyTaskCubit>(context).updateMyTask(_task);
                    },
                    child: SizedBox(
                        width: 25.w,
                        height: double.infinity,
                        child: _task.isComplete
                            ? SvgPicture.asset(
                                IconConstants.checkedIcon,
                              )
                            : SvgPicture.asset(
                                IconConstants.unCheckIcon,
                              )),
                  ),
                  title: Text(_task.description,
                      style: TextStyle(
                          fontSize: 20,
                          decoration: _task.isComplete
                              ? TextDecoration.lineThrough
                              : null)),
                  subtitle: Text(_task.dueDate.toString(),
                      style: TextStyle(
                          decoration: _task.isComplete
                              ? TextDecoration.lineThrough
                              : null)),
                ),
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: _task.isComplete
                      ? ColorConstants.kPrimaryDarkColor
                      : Colors.blue,
                  width: 5.0,
                ))),
              ),
            ],
          ),
        ),
      );
    });
  }
}
