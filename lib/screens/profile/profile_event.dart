abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {}

class ProvideImagePath extends ProfileEvent {
  ProvideImagePath({
    required this.avarPath,
  });

  final String avarPath;
}

class ProfileDescriptionChanged extends ProfileEvent {
  ProfileDescriptionChanged({
    required this.description,
  });
  final String description;
}

class SaveProfileChanged extends ProfileEvent {}
