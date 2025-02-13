part of 'login_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
}

class LoginState extends Equatable {
  final EmailAddress email;
  final Password password;
  final FormSubmissionStatus formSubmissionStatus;

  final OAuthProvider provider;
  final String idToken;
  final String accessToken;

  const LoginState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
    this.provider = OAuthProvider.google,
    this.idToken = '',
    this.accessToken = '',
  });

  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    FormSubmissionStatus? formSubmissionStatus,
    OAuthProvider? provider,
    String? idToken,
    String? accessToken,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        provider: provider ?? this.provider,
        idToken: idToken ?? this.idToken,
        accessToken: accessToken ?? this.accessToken,
      );

  @override
  List<Object> get props =>
      [email, password, formSubmissionStatus, provider, idToken, accessToken];

  bool isSubmiting() => formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure;

  bool get isValid => !email.hasError && !password.hasError;
}

final class LoginInitial extends LoginState {}
