import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/screens/home/my_task/components/slidable_task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:asking/models/Task.dart';
import 'package:asking/constants/extension_function.dart';

class MonthlyTaskView extends StatefulWidget {
  MonthlyTaskView({
    Key? key,
    required this.tasksByDay,
  }) : super(key: key);

  final Map<TemporalDate?, List<Task>> tasksByDay;

  @override
  _MonthlyTaskViewState createState() => _MonthlyTaskViewState();
}

class _MonthlyTaskViewState extends State<MonthlyTaskView>
    with SingleTickerProviderStateMixin {
  bool _isExpand = false;
  late DateRangePickerController _datePickerController;

  late AnimationController _controller;
  late Animation<double> _animation;
  DateTime _selectedDateTime = DateTime.now();
  late List<Task> _tasksInDay;
  late List<DateTime> _listActiveDay;

  @override
  void initState() {
    _datePickerController = DateRangePickerController();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
        value: 0,
        lowerBound: 0.0,
        upperBound: 0.5);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    super.initState();
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tasksInDay = _getTasksInDay(_selectedDateTime, widget.tasksByDay);
    _listActiveDay =
        _convertListTemporalToLocalDate(widget.tasksByDay.keys.toList());
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInSine,
                height: _isExpand ? 340.h : 160.h,
                child: SfDateRangePicker(
                  monthFormat: 'MMM',
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs dateTime) {
                    _onSelectionChanged(dateTime);
                  },
                  initialSelectedDate: DateTime.now(),
                  allowViewNavigation: _isExpand ? true : false,
                  controller: _datePickerController,
                  navigationMode: DateRangePickerNavigationMode.scroll,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  selectionColor: Color(0xFF6074F9),
                  headerHeight: 70.h,
                  selectionMode: DateRangePickerSelectionMode.single,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  view: DateRangePickerView.month,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      specialDates: _listActiveDay,
                      viewHeaderHeight: 30.h,
                      numberOfWeeksInView: _isExpand ? 6 : 1,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      showTrailingAndLeadingDates: true),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    specialDatesTextStyle: const TextStyle(color: Colors.black),
                    specialDatesDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        border: Border.all(
                            color: const Color(0xFF7EB5A6), width: 1),
                        shape: BoxShape.rectangle),
                    todayCellDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        border: Border.all(
                            color: const Color(0xFF3D087B), width: 1),
                        shape: BoxShape.rectangle),
                    todayTextStyle: const TextStyle(color: Colors.purple),
                  ),
                ),
              ),
              Positioned(
                left: 240.w,
                top: 20.h,
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: RotationTransition(
                    turns: _animation,
                    child: GestureDetector(
                        onTap: () {
                          _expandOnTap();
                        },
                        child: Icon(Icons.expand_more_outlined, size: 30.sp)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: _tasksInDay.length != 0
                    ? NotificationListener<ScrollNotification>(
                        child: ListView.builder(
                            itemCount: _tasksInDay.length,
                            itemBuilder: (context, index) {
                              final task = _tasksInDay[index];
                              return _slidableTaskTile(task);
                            }),
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollStartNotification) {
                            if (_isExpand == true) {
                              setState(() {
                                _isExpand = false;
                              });
                              _controller.reverse();
                            }

                            return true;
                          }
                          return true;
                        },
                      )
                    : Center(
                        child: Lottie.asset(AnimationConstants.emptyTask,
                            frameRate: FrameRate(60.0))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _slidableTaskTile(Task task) => SlidableTaskTile(task: task);

  List<DateTime> _convertListTemporalToLocalDate(
      List<TemporalDate?> tempporalDate) {
    List<DateTime> listLocalDate = [];

    if (tempporalDate.length != 0) {
      tempporalDate.forEach((date) {
        if (!date!.getDateTime().isSameDate(DateTime.now())) {
          listLocalDate.add(date.getDateTime());
        }
      });
    }

    return listLocalDate;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs dateTime) {
    setState(() {
      _selectedDateTime = dateTime.value;
      _tasksInDay = _getTasksInDay(dateTime.value, widget.tasksByDay);
    });
  }

  void _expandOnTap() {
    setState(() {
      _isExpand ? _controller.reverse() : _controller.forward();
      _isExpand = _isExpand ? false : true;

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _datePickerController.displayDate = DateTime.now();
      });
    });
  }

  List<Task> _getTasksInDay(
      DateTime dateTime, Map<TemporalDate?, List<Task>> tasksByDay) {
    TemporalDate tempporalDateTime;

    if (dateTime != DateTime.now()) {
      tempporalDateTime = TemporalDate(
          DateTime(dateTime.year, dateTime.month, dateTime.day + 1));
    } else {
      tempporalDateTime =
          TemporalDate(DateTime(dateTime.year, dateTime.month, dateTime.day));
    }
    return tasksByDay[tempporalDateTime]?.reversed.toList() ?? [];
  }
}
