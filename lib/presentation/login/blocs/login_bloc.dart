import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart';
import 'package:my_movie/domain/authentication/entities/email_address.dart';
import 'package:my_movie/domain/authentication/entities/password.dart';

part 'login_event.dart';
part 'login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthenticationRepository _authenticationRepository;

  LoginBloc(this._authenticationRepository) : super(LoginInitial()) {
    on<LoginEmailAddressChanged>(_onEmailAddressChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onEmailAddressChanged(
      LoginEmailAddressChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
          email: EmailAddress.create(event.value!),
          formSubmissionStatus: FormSubmissionStatus.initial),
    );
  }

  Future<void> _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
          password: Password.create(event.value!),
          formSubmissionStatus: FormSubmissionStatus.initial),
    );
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));

    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.failure));
    }
  }
}
