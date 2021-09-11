import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/screens/home/quick_view/quick_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickNoteView extends StatefulWidget {
  const QuickNoteView({Key? key}) : super(key: key);

  @override
  _QuickNoteViewState createState() => _QuickNoteViewState();
}

class _QuickNoteViewState extends State<QuickNoteView> {
  bool _wantToEdit = false;

  @override
  Widget build(BuildContext context) {
    final QuickCubit quickCubit = context.read<QuickCubit>();
    final quickNotes = quickCubit.quickNotes;

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              _wantToEdit = _wantToEdit ? false : true;
            });
          },
          child: Container(
              width: 50.w,
              height: 50.h,
              margin: EdgeInsets.only(bottom: 40.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: ColorConstants.kPrimaryGradientColor),
              child: Icon(Icons.edit, color: Colors.white))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView.builder(
          itemCount: quickNotes.length,
          itemBuilder: (context, index) {
            final quickNote = quickNotes[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: Card(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                          color: ExtensionFunction.hexToColor(quickNote.color),
                          width: 2.0.w,
                        ))),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: Key(quickNote.description),
                              initialValue: quickNote.description,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              readOnly: _wantToEdit ? false : true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter something',
                              ),
                              onFieldSubmitted: (description) {
                                final updatedQuickNote = quickNote.copyWith(
                                    description: description);
                                quickCubit.updateQuickNote(updatedQuickNote);
                              },
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible: _wantToEdit,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        quickCubit.deleteQuickNote(quickNote);
                                      },
                                      child: Icon(Icons.delete_outlined,
                                          size: 22.sp))),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ]),
              )),
            );
          }),
    );
  }
}
