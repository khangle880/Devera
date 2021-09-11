import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/popup_modal/add_check_list_modal/add_check_list_bloc.dart';
import 'package:asking/widgets/custom_text_button.dart';

class CreateCheckListButton extends StatelessWidget {
  const CreateCheckListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCheckListBloc, AddCheckListState>(
      builder: (context, state) {
        return CustomTextButton(
            text: 'Done',
            color: ColorConstants.kButtonColor,
            textColor: Colors.white,
            isLoading: false,
            onPressed: () async {
              context.read<AddCheckListBloc>().add(CreateCheckList());
              Navigator.of(context).pop();
            });
      },
    );
  }
}
