import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/resend_code/resend_code_event.dart';
import 'package:asking/auth/resend_code/resend_code_state.dart';

class ResendCodeBloc extends Bloc<ResendCodeEvent, ResendCodeState> {
  ResendCodeBloc({required this.authRepo, required this.authCubit})
      : super(ResendCodeState());

  final AuthRepository authRepo;
  final AuthCubit authCubit;
  @override
  Stream<ResendCodeState> mapEventToState(ResendCodeEvent event) async* {
    if (event is ResendCodeUserNameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is ResendSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.resendSignUpCode(username: state.username);

        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmResendCode(username: state.username);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
      }
    }
  }
}
