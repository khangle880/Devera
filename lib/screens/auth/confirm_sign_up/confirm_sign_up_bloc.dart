import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/confirm_sign_up/confirm_sign_up_event.dart';
import 'package:icon/screens/auth/confirm_sign_up/confirm_sign_up_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    final credentials = authCubit.credentials;
    // Confirmation code updated
    if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.confirmSignUp(
          username: authCubit.credentials!.email,
          confirmationCode: event.code,
        );

        yield state.copyWith(formStatus: SubmissionSuccess());

        final userId = await authRepo.login(
          username: credentials!.email,
          password: credentials.password,
        );
        credentials.userId = userId;

        authCubit.launchSession(credentials);
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    } else if (event is ResendSecurityCode) {
      authRepo.resendSignUpCode(username: credentials!.email);
    }
  }
}
