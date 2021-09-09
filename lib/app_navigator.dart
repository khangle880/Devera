import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/auth_navigator.dart';
import 'package:icon/screens/home/home_view.dart';
import 'package:icon/session/session_cubit.dart';
import 'package:icon/session/session_state.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        print(state);
        return Navigator(
          key: UniqueKey(),
          pages: [
            if (state is UnknownSessionState)
              MaterialPage(child: Center(child: CircularProgressIndicator())),

            // Show auth flow
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: AuthNavigator(),
                ),
              ),

            // Show home flow
            if (state is Authenticated) MaterialPage(child: HomeView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
