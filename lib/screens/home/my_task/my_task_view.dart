import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/my_task/monthly_task/montly_task_view.dart';
import 'package:asking/screens/home/my_task/my_task_cubit.dart';
import 'package:asking/screens/home/my_task/my_task_state.dart';
import 'package:asking/screens/home/my_task/today_task/today_task_view.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTaskView extends StatefulWidget {
  const MyTaskView({Key? key}) : super(key: key);

  @override
  _MyTaskViewState createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => MyTaskCubit(
          dataRepo: context.read<DataRepository>(),
          user: sessionCubit.selectedUser ??
              sessionCubit.currentUser ??
              User(username: 'N/A'))
        ..getMyTask()
        ..observeMyTasks(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorConstants.kPrimaryDarkColor,
          title: Text('My Task', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: FocusedMenuHolder(
                  duration: Duration.zero,
                  menuWidth: 200.w,
                  animateMenuItems: false,
                  openWithTap: true,
                  onPressed: () {},
                  menuItems: [
                    FocusedMenuItem(
                        title: Text('Incomplete Tasks'),
                        onPressed: () {},
                        trailingIcon: Icon(Icons.check, color: Colors.green)),
                    FocusedMenuItem(
                        title: Text('Completed Tasks'), onPressed: () {}),
                    FocusedMenuItem(title: Text('All Tasks'), onPressed: () {}),
                  ],
                  child: SvgPicture.asset(IconConstants.addIcon)),
            )
          ],
        ),
        body: Column(children: <Widget>[
          Container(
            color: ColorConstants.kPrimaryLightColor,
            child: TabBar(
              indicatorWeight: 0.1,
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              isScrollable: false,
              unselectedLabelColor: Color(0xFFc9c9c9).withOpacity(0.5),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: _selectedIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                      width: 4.0,
                    ))),
                    child: Text(
                      'Today',
                      style: TextStyle(fontSize: 21.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: _selectedIndex == 1
                          ? Colors.white
                          : Colors.transparent,
                      width: 4.0,
                    ))),
                    child: Text(
                      'Month',
                      style: TextStyle(fontSize: 21.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<MyTaskCubit, MyTaskState>(
              builder: (context, state) {
                if (state is GetMyTaskFailed) {
                } else if (state is GetMyTaskSuccess) {
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      TodayTaskView(
                        tasksByDay: state.tasksByDay,
                      ),
                      MonthlyTaskView(
                        tasksByDay: state.tasksByDay,
                      ),
                    ],
                  );
                }

                return LoadingView();
              },
            ),
          )
        ]),
      ),
    );
  }
}
