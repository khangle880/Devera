import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:icon/models/ModelProvider.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/screens/auth/auth_credentials.dart';
import 'package:icon/session/session_state.dart';

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
  }) : super(Unauthenticated());

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials) async {
    try {
      print('Trigger Here');
      print(credentials.userId);
      User? user = await dataRepo.getUserById(userId: credentials.userId);

      if (user == null) {
        final wallet = await FlutterIconNetwork.instance!.createWallet;

        final createdWallet = await dataRepo.createWallet(
          address: wallet.address ?? '',
          privateKey: wallet.privateKey ?? '',
        );

        user = await dataRepo.createUser(
            userId: credentials.userId,
            firstName: credentials.firstName,
            lastName: credentials.lastName,
            email: credentials.email,
            pin: credentials.pin,
            wallet: createdWallet);
      }

      emit(Authenticated(user: user));
    } catch (e) {
      print(e);
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
