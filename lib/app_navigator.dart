import 'package:asking/screens/home/home_cubit.dart';
import 'package:asking/screens/home/home_navigator.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_navigator.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:asking/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

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
          if (state is Authenticated)
            MaterialPage(
                child: BlocProvider(
                    create: (context) => HomeCubit(), child: HomeNavigator()))
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
