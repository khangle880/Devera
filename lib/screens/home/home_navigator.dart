import 'package:asking/screens/home/home_cubit.dart';
import 'package:asking/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      print(state);
      return Navigator(
        pages: [
          MaterialPage(child: HomeView()),
          if (state == HomeState.addCheckList ||
              state == HomeState.addNote ||
              state == HomeState.home) ...[
            // Show home view
          ]
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    });
  }
}
