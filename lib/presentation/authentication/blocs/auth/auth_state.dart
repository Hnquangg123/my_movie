part of 'auth_bloc.dart';

enum AuthenticationStatus { signIn, signout, checkAuthStatus }

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthUserAuthenticated extends AuthState {
  final User user;

  AuthUserAuthenticated(this.user);
}

final class AuthUserUnauthenticated extends AuthState {}
