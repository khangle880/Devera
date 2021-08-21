import 'package:asking/models/User.dart';
import 'package:asking/screens/profile/profile_bloc.dart';
import 'package:asking/screens/profile/profile_state.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          user: sessionCubit.selectedUser ??
              sessionCubit.currentUser ??
              User(username: 'N/A'),
          isCurrentUser: sessionCubit.isCurrentUserSelected),
      child: Scaffold(backgroundColor: Color(0xFFF2F2F7), body: _profilePage()),
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
          if (state.isCurrentUser) _saveProfileButton()
        ],
      )));
    });
  }

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CircleAvatar(radius: 50, child: Icon(Icons.person));
      },
    );
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return TextButton(onPressed: () {}, child: Text('Change Avatar'));
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
          ),
        );
      },
    );
  }

  Widget _saveProfileButton() {
    final sessionCubit = context.read<SessionCubit>();
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              sessionCubit.signOut();
            },
            child: Text('Save changes'));
      },
    );
  }
}
