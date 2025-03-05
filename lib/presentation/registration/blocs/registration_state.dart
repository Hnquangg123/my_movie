part of 'registration_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
  confirmPasswordNotMatchWithPassword,
}

final class RegistrationState extends Equatable {
  final EmailAddress email;
  final Password password;
  final Password confirmPassword;
  final FormSubmissionStatus formSubmissionStatus;
  final bool tickPolicy;

  const RegistrationState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.confirmPassword = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
    this.tickPolicy = false,
  });

  RegistrationState copyWith({
    EmailAddress? email,
    Password? password,
    Password? confirmPassword,
    FormSubmissionStatus? formSubmissionStatus,
    bool? tickPolicy,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        tickPolicy: tickPolicy ?? this.tickPolicy,
      );

  @override
  List<Object> get props =>
      [email, password, confirmPassword, formSubmissionStatus, tickPolicy];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isTickPolicy() => tickPolicy == true;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure ||
      formSubmissionStatus ==
          FormSubmissionStatus.confirmPasswordNotMatchWithPassword;

  bool get isValid =>
      !email.hasError && !password.hasError && !confirmPassword.hasError;
}

final class RegistrationInitial extends RegistrationState {}
