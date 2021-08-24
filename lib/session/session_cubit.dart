import 'package:amplify_api/amplify_api.dart';
import 'package:asking/models/User.dart';
import 'package:asking/screens/auth/auth_credentials.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/session/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/repositories/data_repository.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final DataRepository dataRepo;

  User? get currentUser => (state as Authenticated).user;
  User? get selectedUser => (state as Authenticated).selectedUser;
  bool get isCurrentUserSelected =>
      selectedUser == null || currentUser?.id == selectedUser?.id;

  SessionCubit({
    required this.authRepo,
    required this.dataRepo,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      User? user = await dataRepo.getUserById(userId: userId);
      if (user == null) {
        user = await dataRepo.createUser(
            userId: userId,
            username: 'User-${UUID()}',
            email: 'User-${UUID()}');
        print(user);
      } else {
        print('Fuck you');
        print(user);
      }

      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials) async {
    try {
      User? user = await dataRepo.getUserById(userId: credentials.userId);

      if (user == null) {
        user = await dataRepo.createUser(
          userId: credentials.userId,
          username: credentials.username,
          email: credentials.username,
        );
      }

      emit(Authenticated(user: user));
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
