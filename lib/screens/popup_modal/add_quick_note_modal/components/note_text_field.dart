import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_bloc.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_event.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode descriptionNode = FocusNode();
    return BlocBuilder<AddQuickNoteBloc, AddQuickNoteState>(
        builder: (context, state) {
      return TextField(
        focusNode: descriptionNode,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        maxLength: 1000,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter something',
          contentPadding: EdgeInsets.symmetric(vertical: 12.0.h),
          suffix: TextButton(
            onPressed: () {
              descriptionNode.unfocus();
            },
            child: Text("Done"),
          ),
        ),
        onChanged: (value) => context
            .read<AddQuickNoteBloc>()
            .add(NoteDescriptionOnChanged(description: value)),
      );
    });
  }
}
