import 'package:amplify_flutter/amplify.dart';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_bloc.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_event.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_state.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AssigneeSearchView extends StatefulWidget {
  const AssigneeSearchView({
    Key? key,
    required this.searchDone,
  }) : super(key: key);

  final VoidCallback searchDone;

  @override
  _AssigneeSearchViewState createState() => _AssigneeSearchViewState();
}

class _AssigneeSearchViewState extends State<AssigneeSearchView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(builder: (context, state) {
      if (state.searchUsers != null || state.searchUsers?.length != 0) {
        return FutureBuilder(
            future: ExtensionFunction.getUsersAvatarUrl(state.searchUsers),
            builder: (BuildContext context,
                AsyncSnapshot<List<String>>? usersAvatarUrl) {
              return Container(
                  height: 568.h,
                  color: Color(0xFFF4F4F4),
                  child: state.searchUsers!.length == 0
                      ? Center(
                          child:
                              Lottie.asset(AnimationConstants.emptyAnimation))
                      : ListView.builder(
                          itemCount: state.searchUsers!.length,
                          itemBuilder: (context, index) {
                            final searchUser = state.searchUsers![index];

                            if (!usersAvatarUrl!.hasData) {
                              return Container(
                                  width: 100,
                                  height: 100,
                                  child: LoadingView());
                            }

                            if (usersAvatarUrl.data!.length != 0) {
                              return ListTile(
                                onTap: () {
                                  widget.searchDone();
                                  context.read<AddTaskBloc>().add(
                                      TaskAssigneeOnChanged(
                                          assignee: state.searchUsers![index]));
                                  context.read<AddTaskBloc>().add(
                                      TaskAssigneeSearchStringOnChanged(
                                          assigneeSearchString: ''));
                                },
                                leading: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent),
                                    width: 40.w,
                                    height: 40.h,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                usersAvatarUrl.data![index],
                                            fit: BoxFit.cover))),
                                title: Text(searchUser.username,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(searchUser.email ?? '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              );
                            }

                            return Container(
                                child: Center(child: Text('Empty')));
                          }));
            });
      }
      return Center(child: Text('Hello World'));
    });
  }

  Future<List<String>>? getUsersAvatarUrl(List<User>? users) async {
    List<String>? usersAvatarUrl = [];

    if (users != null || users!.length > 0) {
      for (var user in users) {
        final userAvatarUrl =
            (await Amplify.Storage.getUrl(key: user.avatarKey ?? '')).url;
        usersAvatarUrl.add(userAvatarUrl);
      }
    }

    return usersAvatarUrl;
  }
}
