import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {
  OpenImagePicker({required this.imageSource});

  final ImageSource imageSource;
}

class ProvideImagePath extends ProfileEvent {
  ProvideImagePath({
    required this.avarPath,
  });

  final String avarPath;
}

class ProfileUsernameChanged extends ProfileEvent {
  ProfileUsernameChanged({
    required this.username,
  });

  final String username;
}

class ProfileDescriptionChanged extends ProfileEvent {
  ProfileDescriptionChanged({
    required this.description,
  });
  final String description;
}

class SaveProfileChanged extends ProfileEvent {}
