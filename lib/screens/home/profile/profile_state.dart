import 'package:asking/models/ModelProvider.dart';
import 'package:asking/constants/form_submission_status.dart';

class ProfileState {
  ProfileState(
      {required this.user,
      required this.isCurrentUser,
      this.avatarPath,
      this.username,
      this.userDescription,
      this.formStatus = const InitialFormStatus(),
      this.imageSourceActionSheetIsVisible = false});

  final User user;
  final bool isCurrentUser;
  final String? avatarPath;
  final String? username;
  final String? userDescription;

  String? get email => user.email != null ? user.email : '';

  FormSubmissionStatus formStatus;
  bool imageSourceActionSheetIsVisible;

  ProfileState copyWith(
      {User? user,
      bool? isCurrentUser,
      String? avatarPath,
      String? username,
      String? userDescription,
      FormSubmissionStatus? formStatus,
      bool? imageSourceActionSheetIsVisible}) {
    return ProfileState(
        user: user ?? this.user,
        isCurrentUser: isCurrentUser ?? this.isCurrentUser,
        avatarPath: avatarPath ?? this.avatarPath,
        username: username ?? this.username,
        userDescription: userDescription ?? this.userDescription,
        formStatus: formStatus ?? this.formStatus,
        imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
            this.imageSourceActionSheetIsVisible);
  }
}
