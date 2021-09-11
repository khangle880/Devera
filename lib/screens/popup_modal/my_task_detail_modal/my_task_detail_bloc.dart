import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/image_url_cache.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/models/User.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_event.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_state.dart';

class MyTaskDetailBloc extends Bloc<MyTaskDetailEvent, MyTaskDetailState> {
  MyTaskDetailBloc({
    required this.task,
  }) : super(MyTaskDetailState());

  final Task task;

  final AuthRepository authRepo = AuthRepository();
  final DataRepository dataRepo = DataRepository();

  @override
  Stream<MyTaskDetailState> mapEventToState(MyTaskDetailEvent event) async* {
    if (event is GetAssigneeInfo) {
      final assignee = await dataRepo.getUserById(userId: event.userID);

      yield state.copyWith(assignee: assignee);

      yield state.copyWith(
          assigneeAvatarPath:
              await ImageUrlCache.instance.getUrl(assignee!.avatarKey ?? ''));
    } else if (event is GetMembersAvatarPath) {
      List<User> members = [];
      event.membersID.forEach((userId) async {
        final user = await dataRepo.getUserById(userId: userId);
        members.add(user ?? User(username: 'N/A'));
      });
      yield state.copyWith(members: members);
    } else if (event is GetComments) {
      try {
        final commemts = await dataRepo.getComments(taskID: task.id);
        print(commemts);
        yield state.copyWith(comments: commemts);
      } catch (e) {
        print(e);
        throw (e);
      }
    } else if (event is CommentOnChanged) {
      yield state.copyWith(commentStr: event.comment);
    } else if (event is ObserveComments) {
      final taskComment = dataRepo.observeComment();
      taskComment.listen((_) {
        add(GetComments());
      });
    } else if (event is CreateComment) {
      try {
        print('Hello World');
        final comment = await dataRepo.createComment(
            avatarKey: state.assignee!.avatarKey ?? '',
            commentStr: state.commentStr ?? '',
            username: state.assignee!.username,
            taskID: task.id);
        print(comment);
      } catch (e) {
        print(e);
        throw (e);
      }
    }
  }
}
