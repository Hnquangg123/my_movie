import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/authentication/screens/home_page.dart';
import 'package:my_movie/presentation/login/blocs/login_bloc.dart';
import 'package:my_movie/presentation/login/widgets/email_input_field.dart';
import 'package:my_movie/presentation/login/widgets/login_button.dart';
import 'package:my_movie/presentation/login/widgets/password_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginForm();
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.isSubmissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Login failed. Please check your credentials.")),
            );
          }
        },
        child: Column(
          children: [
            EmailInputField(),
            SizedBox(height: 8.0),
            PasswordInputField(),
            SizedBox(height: 8.0),
            LoginButton(),
          ],
        ),
      );
}
