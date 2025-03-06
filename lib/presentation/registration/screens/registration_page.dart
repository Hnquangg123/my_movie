import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/login/screens/login_page.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';
import 'package:my_movie/presentation/registration/widgets/confirm_password_input_field.dart';
import 'package:my_movie/presentation/registration/widgets/email_input_field.dart';
import 'package:my_movie/presentation/registration/widgets/password_input_field.dart';
import 'package:my_movie/presentation/registration/widgets/policy_tickbox.dart';
import 'package:my_movie/presentation/registration/widgets/register_button.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>(),
      child: const Scaffold(
        body: _RegistrationForm(),
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  const _RegistrationForm({super.key});

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
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              EmailInputField(),
              PasswordInputField(),
              ConfirmPasswordInputField(),
              PolicyTickbox(),
              RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}






