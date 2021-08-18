import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:asking/auth/auth_credentials.dart';
import 'package:asking/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/auth/login/login_event.dart';
import 'package:asking/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState());

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
        final userId = await authRepo.login(
          username: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit.launchSession(AuthCredentials(
          username: state.email,
          userId: userId,
        ));
      } on UserNotConfirmedException catch (e) {
        if (e is UserNotConfirmedException) {
          authRepo.resendSignUpCode(username: state.email);
          authCubit.showConfirmResendCode(username: state.email);
        } else {
          yield state.copyWith(formStatus: SubmissionFailed(exception: e));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      }
    }
  }
}
