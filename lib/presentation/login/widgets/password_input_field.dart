import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/login/blocs/login_bloc.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.password != previous.password,
      builder: (context, state) => TextFormField(
        onChanged: (password) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(value: password)),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText:
              state.password.hasError ? state.password.errorMessage : null,
        ),
      ),
    );
  }
}
