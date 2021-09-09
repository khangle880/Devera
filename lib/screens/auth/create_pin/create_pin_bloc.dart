import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:icon/screens/auth/create_pin/create_pin_event.dart';
import 'package:icon/screens/auth/create_pin/create_pin_state.dart';

class CreatePinBloc extends Bloc<CreatePinEvent, CreatePinState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  CreatePinBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(CreatePinState());

  @override
  Stream<CreatePinState> mapEventToState(CreatePinEvent event) async* {
    // Confirmation code updated
    if (event is CreatePinSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        authCubit.credentials?.pin = event.pin;
        print(authCubit.credentials?.pin);
        authCubit.showConfirmPin();
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
