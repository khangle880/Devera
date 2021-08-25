import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/screens/auth/sign_up/sign_up_event.dart';
import 'package:asking/screens/auth/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    }
    //? Password updated
    else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    }
    //? Form submitted
    else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        if (state.password == state.confirmPassword) {
          await authRepository.signUp(
              username: state.email,
              email: state.email,
              password: state.password);
          yield state.copyWith(formStatus: SubmissionSuccess());

          authCubit.showConfirmSignUp(
              username: state.email,
              email: state.email,
              password: state.password);
        } else {
          throw Exception('Password are not match');
        }
      } on Exception catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));

        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
