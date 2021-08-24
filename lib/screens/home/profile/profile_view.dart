import 'dart:io';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/models/User.dart';
import 'package:asking/screens/auth/form_submission_status.dart';
import 'package:asking/screens/home/profile/profile_bloc.dart';
import 'package:asking/screens/home/profile/profile_event.dart';
import 'package:asking/screens/home/profile/profile_state.dart';

import 'package:asking/session/session_cubit.dart';
import 'package:asking/repositories/storage_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => ProfileBloc(
          dataRepo: context.read<DataRepository>(),
          storageRepo: context.read<StorageRepository>(),
          user: sessionCubit.selectedUser ??
              sessionCubit.currentUser ??
              User(username: 'N/A'),
          isCurrentUser: sessionCubit.isCurrentUserSelected),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.imageSourceActionSheetIsVisible == true) {
            _showImageSourceActionSheet(context);
          }
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            ExtensionFunction.showSnackBar(
                context, formStatus.exception.toString());
          }
        },
        child:
            Scaffold(backgroundColor: Color(0xFFF2F2F7), body: _profilePage()),
      ),
    );
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Center(
              child: Column(
        children: <Widget>[
          SizedBox(height: 30.h),
          _avatar(),
          if (state.isCurrentUser) _changeAvatarButton(),
          SizedBox(height: 30.h),
          _usernameTile(),
          _emailTile(),
          _descriptionTile(),
          SizedBox(height: 30.h),
          if (state.isCurrentUser) _saveProfileButton(),
          TextButton(
              onPressed: () => context.read<SessionCubit>().signOut(),
              child: Text('log out'))
        ],
      )));
    });
  }

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.transparent),
            width: 100.w,
            height: 100.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: CachedNetworkImage(
                imageUrl: state.avatarPath ?? ImageConstants.defaultAvatar,
                fit: BoxFit.cover,
              ),
            ));
      },
    );
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () =>
                context.read<ProfileBloc>().add(ChangeAvatarRequest()),
            child: Text('Change Avatar'));
      },
    );
  }

  Widget _usernameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.person),
          title: Text(state.username),
        );
      },
    );
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.mail),
          title: Text(state.email ?? 'Not registered'),
        );
      },
    );
  }

  Widget _descriptionTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.mail),
          title: TextFormField(
            decoration: InputDecoration.collapsed(
                hintText: 'Say hello to my little friend'),
            maxLines: null,
            onChanged: (value) => context
                .read<ProfileBloc>()
                .add(ProfileDescriptionChanged(description: value)),
          ),
        );
      },
    );
  }

  Widget _saveProfileButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () =>
                context.read<ProfileBloc>().add(SaveProfileChanged()),
            child: Text('Save changes'));
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSource) {
      context
          .read<ProfileBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    };

    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: Text('Camera'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      selectImageSource(ImageSource.camera);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Gallery'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      selectImageSource(ImageSource.gallery);
                    },
                  ),
                ],
              ));
    } else {
      showBottomSheet(
          context: context,
          builder: (context) => Wrap(children: [
                ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      selectImageSource(ImageSource.camera);
                    }),
                ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text('Gallery'),
                    onTap: () {
                      Navigator.of(context).pop();
                      selectImageSource(ImageSource.gallery);
                    })
              ]));
    }
  }
}
