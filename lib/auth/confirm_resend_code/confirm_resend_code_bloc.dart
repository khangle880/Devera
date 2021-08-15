import 'package:asking/auth/confirm_resend_code/confirm_resend_code_event.dart';
import 'package:asking/auth/confirm_resend_code/confirm_resend_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';

class ConfirmationResendCodeBloc
    extends Bloc<ConfirmationResendCodeEvent, ConfirmationResendCodeState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationResendCodeBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationResendCodeState());

  @override
  Stream<ConfirmationResendCodeState> mapEventToState(
      ConfirmationResendCodeEvent event) async* {
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

        authCubit.showLogin();
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
      }
    }
  }
}
