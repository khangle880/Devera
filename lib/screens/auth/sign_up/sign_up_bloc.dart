import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_credentials.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/sign_up/sign_up_event.dart';
import 'package:icon/screens/auth/sign_up/sign_up_state.dart';

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
    } else if (event is SignUpFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is SignUpLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        // await authRepository.signUp(
        //     username: state.email,
        //     email: state.email,
        //     password: state.password);
        // yield state.copyWith(formStatus: SubmissionSuccess())
        authCubit.credentials = AuthCredentials(
            firstName: state.firstName,
            lastName: state.lastName,
            email: state.email,
            password: state.password);

        authCubit.showCreatePin();
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));

        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
