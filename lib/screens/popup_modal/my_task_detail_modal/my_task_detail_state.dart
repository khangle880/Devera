import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/models/ModelProvider.dart';

class MyTaskDetailState {
  MyTaskDetailState({
    this.assignee,
    this.members,
    this.comments = const [],
    this.commentStr,
    this.assigneeAvatarPath,
    this.formStatus = const InitialFormStatus(),
  });

  User? assignee;
  List<User>? members;
  String? assigneeAvatarPath;
  List<Comment> comments;
  String? commentStr;
  FormSubmissionStatus formStatus;

  MyTaskDetailState copyWith({
    User? assignee,
    List<User>? members,
    List<Comment>? comments,
    String? commentStr,
    String? assigneeAvatarPath,
    FormSubmissionStatus? formStatus,
  }) {
    return MyTaskDetailState(
      assignee: assignee ?? this.assignee,
      members: members ?? this.members,
      comments: comments ?? this.comments,
      commentStr: commentStr ?? this.commentStr,
      assigneeAvatarPath: assigneeAvatarPath ?? this.assigneeAvatarPath,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
