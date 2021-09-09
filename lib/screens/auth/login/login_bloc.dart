import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/models/ModelProvider.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/screens/auth/auth_credentials.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/login/login_event.dart';
import 'package:icon/screens/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState());

  final DataRepository dataRepo = DataRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signOut();

        final userId = await authRepo.login(
          username: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        final User? users = await dataRepo.getUserById(userId: userId);
        if (users != null) {
          authCubit.credentials = AuthCredentials(
              userId: users.id,
              firstName: users.firstName ?? '',
              lastName: users.lastName ?? '',
              email: users.email ?? '',
              pin: users.pin);
          print(users.id);
          print(users.firstName);
          print(users.pin);
        } else {
          throw Exception('User not Found');
        }

        authCubit.showPinSecurity();
      } on Exception catch (e) {
        print(e);
        if (e is InvalidStateException) {
          authRepo.signOut();
          yield state.copyWith(formStatus: FormSubmitting());
          add(LoginSubmitted());
        }

        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
