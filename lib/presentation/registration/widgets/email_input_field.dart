import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField();

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
