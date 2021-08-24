import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_bloc.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_event.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuickNoteBloc, AddQuickNoteState>(
        builder: (context, state) {
      return TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        maxLength: 1000,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter something',
          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
        ),
        onChanged: (value) => context
            .read<AddQuickNoteBloc>()
            .add(NoteDescriptionOnChanged(description: value)),
      );
    });
  }
}
