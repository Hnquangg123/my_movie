part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialCheckRequested extends AuthEvent {}

class AuthOnCurrentUserChanged extends AuthEvent {
  final User? user;

  AuthOnCurrentUserChanged({this.user});
}

class AuthLogoutButtonPressed extends AuthEvent {}
