import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_credentials.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/pin_security/pin_security_event.dart';
import 'package:icon/screens/auth/pin_security/pin_security_state.dart';

class PinSecurityBloc extends Bloc<PinSecurityEvent, PinSecurityState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  PinSecurityBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(PinSecurityState());

  @override
  Stream<PinSecurityState> mapEventToState(PinSecurityEvent event) async* {
    final credential = authCubit.credentials;
    // Confirmation code updated
    if (event is PinSecuritySubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        authCubit.launchSession(AuthCredentials(
            userId: credential!.userId,
            email: credential.email,
            firstName: credential.firstName,
            lastName: credential.lastName));
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
