import 'package:asking/screens/popup_modal/add_check_list_modal/add_check_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode descriptionNode = FocusNode();
    return BlocBuilder<AddCheckListBloc, AddCheckListState>(
      builder: (context, state) {
        return TextField(
          focusNode: descriptionNode,
          keyboardType: TextInputType.multiline,
          maxLines: 2,
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
          onChanged: (description) {
            context
                .read<AddCheckListBloc>()
                .add(CheckListDescriptionOnChanged(description: description));
          },
        );
      },
    );
  }
}
