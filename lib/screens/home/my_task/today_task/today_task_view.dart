import 'package:asking/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodayTaskView extends StatefulWidget {
  const TodayTaskView({Key? key}) : super(key: key);

  @override
  _TodayTaskViewState createState() => _TodayTaskViewState();
}

class _TodayTaskViewState extends State<TodayTaskView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(6),
              child: Slidable(
                child: _buildListTile(),
                actionPane: SlidableStrechActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: [
                  Container(
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
                        onTap: () {}),
                  ),
                  IconSlideAction(
                      foregroundColor: Colors.red,
                      color: Colors.white,
                      icon: Icons.tram_sharp,
                      onTap: () {}),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildListTile() => Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: SizedBox(
                      height: double.infinity, child: Icon(Icons.check_box)),
                  title: Text('Helo Therer', style: TextStyle(fontSize: 20)),
                  subtitle: Text('Oh No Im Idiot'),
                ),
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: Colors.blue,
                  width: 5.0,
                ))),
              )
            ],
          ),
        ),
      );
}
