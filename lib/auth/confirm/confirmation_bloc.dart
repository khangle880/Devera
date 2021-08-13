import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/confirm/confirmation_event.dart';
import 'package:asking/auth/confirm/confirmation_state.dart';
import 'package:asking/auth/form_submission_status.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);

      // Form submitted
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.confirmSignUp(
          username: authCubit.credentials!.username,
          confirmationCode: state.code,
        );

        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        final userId = await authRepo.login(
          username: credentials!.username,
          password: credentials.password,
        );
        credentials.userId = userId;

        authCubit.launchSession(credentials);
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
      }
    }
  }
}
