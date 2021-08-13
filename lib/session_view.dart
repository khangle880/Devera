import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/session_cubit.dart';

class SessionView extends StatelessWidget {
  const SessionView({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hello $username'),
        TextButton(
            child: Text('Sign Out'),
            onPressed: () => BlocProvider.of<SessionCubit>(context).signOut()),
      ],
    )));
  }
}
