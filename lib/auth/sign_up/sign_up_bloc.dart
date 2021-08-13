import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/auth/sign_up/sign_up_event.dart';
import 'package:asking/auth/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  SignUpBloc({
    required this.authRepository,
    required this.authCubit,
  }) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    //? Username updated
    if (event is SignUpUserNameChange) {
      yield state.copyWith(username: event.username);
    }
    //? Password updated
    else if (event is SignUpPasswordChange) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    }
    //? Form submitted
    else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepository.signUp(
            username: state.username,
            email: state.email,
            password: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmSignUp(
            username: state.username,
            email: state.email,
            password: state.password);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
      }
    }
  }
}
