import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionTextfield extends StatelessWidget {
  const DescriptionTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.lightbulb),
          title: TextFormField(
            initialValue: state.userDescription,
            decoration: InputDecoration.collapsed(
                hintText: 'Say hello to my little friend'),
            maxLines: null,
            onChanged: (value) => context
                .read<ProfileBloc>()
                .add(ProfileDescriptionChanged(description: value)),
          ),
        );
      },
    );
  }
}
