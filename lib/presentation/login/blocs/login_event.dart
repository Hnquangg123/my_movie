part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailAddressChanged extends LoginEvent {
  final String? value;

  // could be wrong
  LoginEmailAddressChanged({this.value});
}

class LoginPasswordChanged extends LoginEvent {
  final String? value;

  LoginPasswordChanged({this.value});
}

class LoginButtonPressed extends LoginEvent {}
