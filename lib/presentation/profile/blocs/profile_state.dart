part of 'profile_bloc.dart';

enum FormUpdateStatus { idle, submitting, success, failure }

class ProfileState extends Equatable {
  final String name;
  final String phone;
  final FormUpdateStatus status;

  const ProfileState({
    required this.name,
    required this.phone,
    this.status = FormUpdateStatus.idle,
  });

  @override
  List<Object> get props => [name, phone, status];

  ProfileState copyWith({
    String? name,
    String? phone,
    FormUpdateStatus? status,
  }) {
    return ProfileState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  bool isSubmitting() => status == FormUpdateStatus.submitting;
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super(name: '', phone: '');
}

class ProfileLoading extends ProfileState {
  const ProfileLoading() : super(name: '', phone: '');
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(
      {required super.name,
      required super.phone,
      FormUpdateStatus status = FormUpdateStatus.idle});
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message}) : super(name: '', phone: '');
}
