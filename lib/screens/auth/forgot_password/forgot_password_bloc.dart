import 'package:asking/screens/auth/auth_cubit.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/screens/auth/forgot_password/forgot_password_event.dart';
import 'package:asking/screens/auth/forgot_password/forgot_password_state.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ForgotPasswordState());

  final AuthRepository authRepo;
  final AuthCubit authCubit;

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is FogotPasswordSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        print(state.email);

        await authRepo.resetPassword(email: state.email);

        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmForgetPasswordCode(email: state.email);
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
