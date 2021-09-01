import 'package:asking/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//? THIS FILE IS ONLY FOR TESTING AUTH FUNCTION IF I RUN OUT OF MONEY ON AWS :>
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
