import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<AuthInitialCheckRequested>(_onInitialCheckRequested);
    on<AuthOnCurrentUserChanged>(_onCurrentUserChanged);
    on<AuthLogoutButtonPressed>(_onLogoutButtonPressed);

    _startUserSubscription();
  }

  Future<void> _onInitialCheckRequested(
      AuthInitialCheckRequested event, Emitter<AuthState> emit) async {
    User? signedUser = _authenticationRepository.getSignedInUser();
    signedUser != null
        ? emit(AuthUserAuthenticated(signedUser))
        : emit(AuthUserUnauthenticated());
  }

  Future<void> _onCurrentUserChanged(
      AuthOnCurrentUserChanged event, Emitter<AuthState> emit) async {
    event.user != null
        ? emit(AuthUserAuthenticated(event.user!))
        : emit(AuthUserUnauthenticated());
  }

  Future<void> _onLogoutButtonPressed(
      AuthLogoutButtonPressed event, Emitter<AuthState> emit) async {
    await _authenticationRepository.signOut();
  }

  void _startUserSubscription() =>
      _userSubscription = _authenticationRepository.getCurrentUser().listen(
            (user) => add(AuthOnCurrentUserChanged(user: user)),
          );

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
