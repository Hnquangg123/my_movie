part of 'auth_bloc.dart';

enum AuthenticationStatus { signIn, signout, checkAuthStatus}

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
