import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';

class PasswordInputField extends StatelessWidget {
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