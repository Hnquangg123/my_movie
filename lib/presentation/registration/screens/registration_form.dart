import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/login/screens/login_page.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => current.isSubmissionSuccessOrFailure(),
      listener: (context, state) {
        if (state.formSubmissionStatus == FormSubmissionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Registration success. Please check your e-mail.'),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }

        if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed.'),
            ),
          );
        }

        if (state.formSubmissionStatus ==
            FormSubmissionStatus.confirmPasswordNotMatchWithPassword) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Confirm password does not match password.'),
          ));
        }
      },
      child: Column(
        children: [
          _EmailInputField(),
          SizedBox(height: 8),
          _PasswordInputField(),
          SizedBox(height: 8),
          _ConfirmPasswordInputField(),
          SizedBox(height: 8),
          _RegisterButton(),
        ],
      ),
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) => current.email != previous.email,
        builder: (context, state) => TextField(
          onChanged: (email) => context
              .read<RegistrationBloc>()
              .add(RegistrationEmailAddressChanged(value: email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            errorText: state.email.hasError ? state.email.errorMessage : null,
          ),
        ),
      );
}

class _PasswordInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) => current.password != previous.password,
        builder: (context, state) => TextFormField(
          onChanged: (password) => context
              .read<RegistrationBloc>()
              .add(RegistrationPasswordChanged(value: password)),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password',
              errorText:
                  state.password.hasError ? state.password.errorMessage : null),
        ),
      );
}

class _ConfirmPasswordInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) =>
            current.confirmPassword != previous.confirmPassword,
        builder: (context, state) => TextFormField(
          onChanged: (confirmPassword) => context
              .read<RegistrationBloc>()
              .add(RegistrationConfirmPasswordChanged(value: confirmPassword)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            errorText: state.confirmPassword.hasError
                ? state.confirmPassword.errorMessage
                : null,
          ),
        ),
      );
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => state.isSubmitting() || !state.isValid
              ? null
              : context
                  .read<RegistrationBloc>()
                  .add(RegistrationRegisterButtonPressed()),
          child: Text(state.isSubmitting() ? 'Submitting' : 'Register'),
        ),
      );
}
