import 'package:asking/screens/popup_modal/add_task_modal/add_task_bloc.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_event.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_state.dart';
import 'package:asking/screens/popup_modal/add_task_modal/components/add_task_form.dart';
import 'package:asking/screens/popup_modal/add_task_modal/components/assignee_search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  _AddTaskViewState createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var _assigneeTextController = TextEditingController();
  var _projectTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetAnimationDuration: Duration(milliseconds: 0),
        insetPadding:
            EdgeInsets.only(top: 60.h, bottom: 15.h, left: 0.w, right: 0.w),
        child: BlocProvider(
          create: (context) => AddTaskBloc()..add(GetUsers()),
          child: BlocListener<AddTaskBloc, AddTaskState>(
              listener: (context, state) {},
              child: BlocBuilder<AddTaskBloc, AddTaskState>(
                  builder: (context, state) {
                return Container(
                    width: 350.w,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(children: [
                              Text('For',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              Container(
                                  width: 70,
                                  child: TextField(
                                    controller: _assigneeTextController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: state.assignee == null
                                          ? 'Assignee'
                                          : state.assignee!.username,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 18.0),
                                    ),
                                    onChanged: (value) {
                                      context.read<AddTaskBloc>().add(
                                          TaskAssigneeSearchStringOnChanged(
                                              assigneeSearchString: value));
                                      context
                                          .read<AddTaskBloc>()
                                          .add(SearchUsers());
                                    },
                                  )),
                              SizedBox(width: 50),
                              Text('Project',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              BlocBuilder<AddTaskBloc, AddTaskState>(
                                builder: (context, state) {
                                  return Container(
                                      width: 70,
                                      child: TextField(
                                        controller: _projectTextController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Project',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 18.0),
                                        ),
                                        onChanged: (value) => context
                                            .read<AddTaskBloc>()
                                            .add(
                                                TaskProjectSearchStringOnChanged(
                                                    projectSearchString:
                                                        value)),
                                      ));
                                },
                              ),
                            ]),
                          ),
                          SizedBox(height: 30.h),
                          if (state.assigneeSearchString.isNotEmpty)
                            assigneeSearchView()
                          else if (state.projectSearchString.isNotEmpty)
                            Center(
                              child: Text('Project'),
                            )
                          else
                            addTaskForm(),
                        ],
                      ),
                    ));
              })),
        ));
  }

  Widget addTaskForm() {
    return AddTaskForm();
  }

  Widget assigneeSearchView() {
    return AssigneeSearchView(
      searchDone: () {
        _assigneeTextController.clear();
      },
    );
  }
}
