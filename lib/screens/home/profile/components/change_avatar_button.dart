import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeAvatarButton extends StatelessWidget {
  const ChangeAvatarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return TextButton(
              onPressed: () =>
                  context.read<ProfileBloc>().add(ChangeAvatarRequest()),
              child: Text('Change Avatar'));
        },
      ),
    );
  }
}
