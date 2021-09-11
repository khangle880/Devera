abstract class MyTaskDetailEvent {}

class GetAssigneeInfo extends MyTaskDetailEvent {
  GetAssigneeInfo({
    required this.userID,
  });

  final String userID;
}

class GetAssigneeAvatarPath extends MyTaskDetailEvent {
  GetAssigneeAvatarPath({required this.avataerPath});
  final String avataerPath;
}

class GetMembersAvatarPath extends MyTaskDetailEvent {
  GetMembersAvatarPath({
    required this.membersID,
  });
  final List<String> membersID;
}

class CommentOnChanged extends MyTaskDetailEvent {
  CommentOnChanged({
    required this.comment,
  });

  final String comment;
}

class CreateComment extends MyTaskDetailEvent {}

class GetComments extends MyTaskDetailEvent {}

class ObserveComments extends MyTaskDetailEvent {}
