import 'dart:io';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/models/User.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/screens/home/home_cubit.dart';
import 'package:asking/screens/home/profile/components/change_avatar_button.dart';
import 'package:asking/screens/home/profile/components/description_textfield.dart';
import 'package:asking/screens/home/profile/components/email_tile.dart';
import 'package:asking/screens/home/profile/components/log_out_button.dart';
import 'package:asking/screens/home/profile/components/save_changed_button.dart';
import 'package:asking/screens/home/profile/components/username_textfield.dart';
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
import 'package:lottie/lottie.dart';

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
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70.h,
              elevation: 0.0,
              backgroundColor: Color(0xFFFDFDFD),
              title: Text('Profiles', style: TextStyle(color: Colors.black)),
            ),
            backgroundColor: Color(0xFFFDFDFD),
            body: _profilePage()),
      ),
    );
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Center(
              child: ListView(
        children: <Widget>[
          Card(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    textColor: Colors.black,
                    trailing: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    title: Row(children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          width: 64.w,
                          height: 64.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: state.avatarPath ??
                                  ImageConstants.defaultAvatar,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Container(
                        width: 200,
                        child: ListTile(
                            title: Text(state.username ?? 'My Bad',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: Text(
                              state.email ?? 'My Bad',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            )),
                      )
                    ]),
                    children: [
                      if (state.isCurrentUser) _changeAvatarButton(),
                      SizedBox(height: 20.h),
                      _usernameTextfield(),
                      _descriptionTextfield(),
                      _emailTile(),
                      SizedBox(height: 30.h),
                      if (state.isCurrentUser) _saveProfileButton(),
                      SizedBox(height: 10.h),
                      if (state.isCurrentUser) _logOutButton()
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Row(children: <Widget>[
                  Container(
                    width: 150,
                    child: ListTile(
                        title: Text(
                            context
                                .read<HomeCubit>()
                                .totalCreatedTask
                                .toString(),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        subtitle: Text('Create Tasks',
                            style: TextStyle(fontWeight: FontWeight.w700))),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 180,
                    child: ListTile(
                        title: Text(
                            context
                                .read<HomeCubit>()
                                .totalCompletedTask
                                .toString(),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        subtitle: Text('Completed Tasks',
                            style: TextStyle(fontWeight: FontWeight.w700))),
                  )
                ]),
              ],
            ),
          )),
          SizedBox(height: 40.h),
          Lottie.asset(AnimationConstants.sorryAnimation,
              frameRate: FrameRate(60.0), width: 150, height: 150),
          Center(
              child: Text(
                  "I haven't created these functions under this card yet :<"))
        ],
      )));
    });
  }

  Widget _changeAvatarButton() {
    return ChangeAvatarButton();
  }

  Widget _usernameTextfield() {
    return UsernameTextField();
  }

  Widget _descriptionTextfield() {
    return DescriptionTextfield();
  }

  Widget _emailTile() {
    return EmailTile();
  }

  Widget _saveProfileButton() {
    return SaveChangedButton();
  }

  Widget _logOutButton() {
    return LogoutButton();
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
