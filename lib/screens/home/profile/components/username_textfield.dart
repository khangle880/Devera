import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.person),
          title: TextFormField(
            initialValue: state.username,
            decoration:
                InputDecoration.collapsed(hintText: 'Your username here'),
            maxLines: null,
            onChanged: (value) => context
                .read<ProfileBloc>()
                .add(ProfileUsernameChanged(username: value)),
          ),
        );
      },
    );
  }
}
