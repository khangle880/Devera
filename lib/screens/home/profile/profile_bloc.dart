import 'dart:io';
import 'package:asking/image_url_cache.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/models/User.dart';
import 'package:asking/screens/auth/form_submission_status.dart';
import 'package:asking/repositories/storage_repository.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
      {required this.user,
      required this.isCurrentUser,
      required this.dataRepo,
      required this.storageRepo})
      : super(ProfileState(user: user, isCurrentUser: isCurrentUser)) {
    ImageUrlCache.instance
        .getUrl(user.avatarKey ?? '')
        .then((url) => add(ProvideImagePath(avarPath: url ?? '')));
  }

  final User user;
  final bool isCurrentUser;
  final DataRepository dataRepo;
  final StorageRepository storageRepo;

  final _picker = ImagePicker();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest) {
      yield state.copyWith(imageSourceActionSheetIsVisible: true);
    } else if (event is OpenImagePicker) {
      yield state.copyWith(imageSourceActionSheetIsVisible: false);
      final XFile? pickedImage =
          await _picker.pickImage(source: event.imageSource);
      if (pickedImage == null) return;

      final imageKey = await storageRepo.uploadFile(File(pickedImage.path));

      final updatedUser = state.user.copyWith(avatarKey: imageKey);

      final result = await Future.wait([
        dataRepo.updateUser(updatedUser),
        storageRepo.getUrlForFile(imageKey),
      ]);

      yield state.copyWith(avatarPath: result.last as String);
    } else if (event is ProvideImagePath) {
      yield state.copyWith(avatarPath: event.avarPath);
    } else if (event is ProfileDescriptionChanged) {
      yield state.copyWith(userDescription: event.description);
    } else if (event is SaveProfileChanged) {
      yield state.copyWith(formStatus: FormSubmitting());

      final updatedUser =
          state.user.copyWith(description: state.userDescription);

      try {
        await dataRepo.updateUser(updatedUser);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}
