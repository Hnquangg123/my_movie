import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';

class ConfirmPasswordInputField extends StatelessWidget {
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
