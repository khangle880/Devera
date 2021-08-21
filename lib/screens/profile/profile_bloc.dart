import 'package:asking/models/User.dart';
import 'package:asking/screens/profile/profile_event.dart';
import 'package:asking/screens/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.user, required this.isCurrentUser})
      : super(ProfileState(user: user, isCurrentUser: isCurrentUser));

  final User user;
  final bool isCurrentUser;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest) {
      //TODO Change Avater herhe
    } else if (event is OpenImagePicker) {
      //TODO Open Image Here
    } else if (event is ProvideImagePath) {
      yield state.copyWith(avatarPath: event.avarPath);
    } else if (event is ProfileDescriptionChanged) {
      yield state.copyWith(userDescription: event.description);
    } else if (event is SaveProfileChanged) {
      //TODO Save Changes Here
    }
  }
}
