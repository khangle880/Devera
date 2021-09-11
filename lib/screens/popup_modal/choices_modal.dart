import 'package:asking/screens/popup_modal/add_check_list_modal/add_check_list_view.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_view.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoicesModal {
  static createAlertDialog(BuildContext context) async {
    return showDialog<Widget>(
      context: context,
      builder: (context) {
        return Dialog(
            insetAnimationDuration: Duration(milliseconds: 0),
            insetPadding: EdgeInsets.only(
                top: 20.h, bottom: 20.h, left: 54.w, right: 54.w),
            child: Wrap(children: [
              ListTile(
                  title: Center(
                      child: Text(
                    'Add Task',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  )),
                  onTap: () {
                    Navigator.of(context).pop();
                    createAddTask(context);
                  }),
              Divider(
                height: 15.0,
                color: Colors.black,
              ),
              ListTile(
                  title: Center(
                      child: Text(
                    'Add Quick Note',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  )),
                  onTap: () {
                    Navigator.of(context).pop();
                    createAddNote(context);
                  }),
              Divider(
                height: 15.0,
                color: Colors.black,
              ),
              ListTile(
                  title: Center(
                      child: Text(
                    'Add Check List',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  )),
                  onTap: () {
                    Navigator.of(context).pop();
                    createCheckList(context);
                  }),
            ]));
      },
    );
  }

  static createAddTask(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return AddTaskView();
        });
  }

  static createAddNote(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddQuickNoteView();
      },
    );
  }

  static createCheckList(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddCheckListView();
        });
  }
}
