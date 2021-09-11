import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/style_constants.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/home/my_task/components/slidable_task_tile.dart';
import 'package:asking/widgets/custom_column_builder.dart';
import 'package:asking/constants/extension_function.dart';

class TodayTaskView extends StatefulWidget {
  const TodayTaskView({
    Key? key,
    required this.myTask,
  }) : super(key: key);

  final Map<TemporalDate?, List<Task>> myTask;

  @override
  _TodayTaskViewState createState() => _TodayTaskViewState();
}

class _TodayTaskViewState extends State<TodayTaskView> {
  final _itemScrollController = ItemScrollController();
  late int todayIndexKey = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollToIndex(todayIndexKey);
    });
  }

  void scrollToIndex(int index) => _itemScrollController.jumpTo(index: index);

  @override
  Widget build(BuildContext context) {
    final _myTask = widget.myTask;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: GestureDetector(
          onTap: () {
            scrollToIndex(todayIndexKey);
          },
          child: Container(
            width: 50.w,
            height: 40.h,
            margin: EdgeInsets.only(top: 5.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: ColorConstants.kPrimaryGradientColor),
            child: Icon(Icons.gps_fixed_outlined, color: Colors.white),
          ),
        ),
        body: _myTask.length != 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemCount: _myTask.length,
                    itemBuilder: (context, index) {
                      String currentIndexDateValue;
                      if (_myTask.keys
                          .elementAt(index)!
                          .getDateTime()
                          .isSameDate(DateTime.now())) {
                        currentIndexDateValue = 'Today';
                        todayIndexKey = index;
                      } else {
                        currentIndexDateValue =
                            _myTask.keys.elementAt(index).toString();
                      }

                      List<Task> currentIndexListTasks =
                          _myTask.values.elementAt(index).reversed.toList();

                      return Center(
                        child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentIndexDateValue,
                                    style: StyleConstants.regularBlurText),
                                CustomColumnBuilder(
                                  itemCount: currentIndexListTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = currentIndexListTasks[index];
                                    return _slidableTaskTile(task);
                                  },
                                ),
                              ],
                            )),
                      );
                    }))
            : Center(
                child: Lottie.asset(AnimationConstants.emptyTask,
                    frameRate: FrameRate(60.0))));
  }

  Widget _slidableTaskTile(Task task) => SlidableTaskTile(task: task);
}
