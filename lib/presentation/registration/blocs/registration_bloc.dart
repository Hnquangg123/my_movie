import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/authentication/entities/email_address.dart';
import 'package:my_movie/domain/authentication/entities/password.dart';
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

@Injectable()
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final IAuthenticationRepository _authenticationRepository;

  RegistrationBloc(this._authenticationRepository)
      : super(RegistrationState()) {
    on<RegistrationRegisterButtonPressed>(_onRegistrationRegisterButtonPressed);
    on<RegistrationEmailAddressChanged>(_onEmailAddressChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegistrationTickPolicyChanged>(_onTickPolicyChanged);
  }

  Future<void> _onRegistrationRegisterButtonPressed(
      RegistrationRegisterButtonPressed event,
      Emitter<RegistrationState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));

    if (!_isConfirmPasswordMatchedWithPassword(
      state.password.value,
      state.confirmPassword.value,
    )) {
      emit(state.copyWith(
          formSubmissionStatus:
              FormSubmissionStatus.confirmPasswordNotMatchWithPassword));

      return;
    }

    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.failure));
    }
  }

  Future<void> _onEmailAddressChanged(RegistrationEmailAddressChanged event,
      Emitter<RegistrationState> emit) async {
    emit(state.copyWith(
      email: EmailAddress.create(event.value!),
      formSubmissionStatus: FormSubmissionStatus.initial,
    ));
  }

  Future<void> _onPasswordChanged(RegistrationPasswordChanged event,
      Emitter<RegistrationState> emit) async {
    emit(state.copyWith(
      password: Password.create(event.value!),
      formSubmissionStatus: FormSubmissionStatus.initial,
    ));
  }

  Future<void> _onConfirmPasswordChanged(
      RegistrationConfirmPasswordChanged event,
      Emitter<RegistrationState> emit) async {
    emit(state.copyWith(
      confirmPassword: Password.create(event.value!),
      formSubmissionStatus: FormSubmissionStatus.initial,
    ));
  }

  Future<void> _onTickPolicyChanged(
      RegistrationTickPolicyChanged event,
      Emitter<RegistrationState> emit) async {
    emit(state.copyWith(
      tickPolicy: event.value,
      formSubmissionStatus: FormSubmissionStatus.initial,
    ));
  }

  bool _isConfirmPasswordMatchedWithPassword(
    String password,
    String confirmPassword,
  ) =>
      password == confirmPassword;
}
