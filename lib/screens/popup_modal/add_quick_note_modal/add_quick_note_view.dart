import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_bloc.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_event.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_state.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/components/create_note_button.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/components/note_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuickNoteView extends StatefulWidget {
  const AddQuickNoteView({Key? key}) : super(key: key);

  @override
  _AddQuickNoteViewState createState() => _AddQuickNoteViewState();
}

class _AddQuickNoteViewState extends State<AddQuickNoteView> {
  Color _colorPicked = Color(0xFF6074F9);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(milliseconds: 0),
      // contentPadding: EdgeInsets.zero,
      insetPadding:
          EdgeInsets.only(top: 60.h, bottom: 200.h, left: 0.w, right: 0.w),
      child: BlocProvider(
        create: (context) => AddQuickNoteBloc(),
        child: BlocListener<AddQuickNoteBloc, AddQuickNoteState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                ExtensionFunction.showSnackBar(
                    context, formStatus.exception.toString());
              }
            },
            child: Container(
              width: 350.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: ListView(children: [
                Text('Description',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kTextColor))),
                SizedBox(height: 5.h),
                _noteTextField(),
                SizedBox(height: 50.h),
                Text('Choose Color',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: _colorPicked))),
                SizedBox(height: 10.h),
                _colorsPicker(),
                SizedBox(height: 30.h),
                _createNoteButton(),
              ]),
            )),
      ),
    );
  }

  Widget _noteTextField() {
    return NoteTextField();
  }

  Widget _createNoteButton() {
    return CreateNoteButton();
  }

  Widget _colorsPicker() {
    return BlocBuilder<AddQuickNoteBloc, AddQuickNoteState>(
        builder: (context, state) {
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _colorPicked = Color(0xFF6074F9);
            });
            context
                .read<AddQuickNoteBloc>()
                .add(NoteColorOnChanged(color: '#6074F9'));
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
                color: Color(0xFF6074F9),
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _colorPicked = Color(0xFFE42B6A);
            });
            context
                .read<AddQuickNoteBloc>()
                .add(NoteColorOnChanged(color: '#E42B6A'));
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
                color: Color(0xFFE42B6A),
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _colorPicked = Color(0xFF5ABB56);
            });
            context
                .read<AddQuickNoteBloc>()
                .add(NoteColorOnChanged(color: '#5ABB56'));
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
                color: Color(0xFF5ABB56),
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _colorPicked = Color(0xFF3D3A62);
            });
            context
                .read<AddQuickNoteBloc>()
                .add(NoteColorOnChanged(color: '#3D3A62'));
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
                color: Color(0xFF3D3A62),
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _colorPicked = Color(0xFFF4CA8F);
            });
            context
                .read<AddQuickNoteBloc>()
                .add(NoteColorOnChanged(color: '#F4CA8F'));
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
                color: Color(0xFFF4CA8F),
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        ),
      ]);
    });
  }
}
