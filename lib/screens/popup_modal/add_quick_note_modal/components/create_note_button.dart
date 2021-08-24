import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_bloc.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_event.dart';
import 'package:asking/screens/popup_modal/add_quick_note_modal/add_quick_note_state.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNoteButton extends StatelessWidget {
  const CreateNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuickNoteBloc, AddQuickNoteState>(
        builder: (context, state) {
      return CustomTextButton(
          text: 'Done',
          color: ColorConstants.kButtonColor,
          textColor: Colors.white,
          isLoading: false,
          onPressed: () async {
            context.read<AddQuickNoteBloc>().add(CreateNote());
            Navigator.of(context).pop();
          });
    });
  }
}
