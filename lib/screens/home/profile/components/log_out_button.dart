import 'package:asking/constants/color_constants.dart';
import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
        outLineButton: true,
        text: 'Log out',
        color: ColorConstants.kPrimaryDarkColor,
        textColor: Colors.black,
        onPressed: () {
          context.read<SessionCubit>().signOut();
        });
  }
}
