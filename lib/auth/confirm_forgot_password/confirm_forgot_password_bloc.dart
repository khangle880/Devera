import 'package:asking/auth/confirm_forgot_password/confirm_forgot_password_event.dart';
import 'package:asking/auth/confirm_forgot_password/confirm_forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';

class ConfirmForgotPasswordBloc
    extends Bloc<ConfirmForgotPasswordEvent, ConfirmForgotPasswordState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmForgotPasswordBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmForgotPasswordState());

  @override
  Stream<ConfirmForgotPasswordState> mapEventToState(
      ConfirmForgotPasswordEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    }
    // Email updated
    else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    // Password updated
    else if (event is ConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    }
    // Form Submitted
    else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        if (state.password == state.confirmPassword) {
          await authRepo.confirmPassword(
              email: authCubit.credentials!.username,
              password: state.password,
              confirmationCode: state.code);

          yield state.copyWith(formStatus: SubmissionSuccess());

          final credentials = authCubit.credentials;

          final userId = await authRepo.login(
            username: credentials!.username,
            password: state.password,
          );

          credentials.userId = userId;

          authCubit.launchSession(credentials);
        } else
          throw Exception('Passwords are not match');
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
