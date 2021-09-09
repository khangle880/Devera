import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/confirm_create_pin/confirm_create_pin_event.dart';
import 'package:icon/screens/auth/confirm_create_pin/confirm_create_pin_state.dart';

class ConfirmCreatePinBloc
    extends Bloc<ConfirmCreatePinEvent, ConfirmCreatePinState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmCreatePinBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmCreatePinState());

  @override
  Stream<ConfirmCreatePinState> mapEventToState(
      ConfirmCreatePinEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmPinSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final credential = authCubit.credentials;

        await authRepo.signUp(
            firstName: credential!.firstName,
            lastName: credential.lastName,
            email: credential.email,
            password: credential.password ?? '',
            pin: credential.pin ?? '');
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmSignUp();
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
