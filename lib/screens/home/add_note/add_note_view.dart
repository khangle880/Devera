import 'package:asking/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorConstants.kPrimaryDarkColor,
          title: Text('Add Note', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Icon(Icons.ac_unit),
            )
          ],
        ),
        body: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('back to home')));
  }
}
