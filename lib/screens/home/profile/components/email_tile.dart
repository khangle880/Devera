import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailTile extends StatelessWidget {
  const EmailTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.mail),
          title: Text(state.email ?? 'Not registered'),
        );
      },
    );
  }
}
