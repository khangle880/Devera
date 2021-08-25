import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveChangedButton extends StatelessWidget {
  const SaveChangedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CustomTextButton(
            text: 'Save Changes',
            color: ColorConstants.kPrimaryDarkColor,
            textColor: Colors.white,
            onPressed: () {
              context.read<ProfileBloc>().add(SaveProfileChanged());
            });
      },
    );
  }
}
