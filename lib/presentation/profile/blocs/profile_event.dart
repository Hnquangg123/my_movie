part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final String name;
  final String phone;

  const UpdateUserProfile({required this.name, required this.phone});

  @override
  List<Object> get props => [name, phone];
}

class ProfileNameChanged extends ProfileEvent {
  final String name;

  const ProfileNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class ProfilePhoneChanged extends ProfileEvent {
  final String phone;

  const ProfilePhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
}
