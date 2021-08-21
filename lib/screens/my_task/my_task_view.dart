import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/my_task/today_task/today_task_view.dart';
import 'package:flutter/material.dart';

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
    return Column(children: <Widget>[
      Container(
        color: ColorConstants.kPrimaryLightColor,
        child: TabBar(
          indicatorWeight: 0.1,
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          isScrollable: false,
          // labelPadding: const EdgeInsets.only(left: 35.0, right: 35.0),
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
                  color:
                      _selectedIndex == 0 ? Colors.white : Colors.transparent,
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
                  color:
                      _selectedIndex == 1 ? Colors.white : Colors.transparent,
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
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            TodayTaskView(),
            Center(child: Text("Transit")),
          ],
        ),
      )
    ]);
  }
}
