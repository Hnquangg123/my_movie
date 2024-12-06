import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/login/blocs/login_bloc.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.email != previous.email,
      builder: (context, state) => TextField(
        onChanged: (email) => context
            .read<LoginBloc>()
            .add(LoginEmailAddressChanged(value: email)),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: 'Email Address',
            errorText: state.email.hasError ? state.email.errorMessage : null),
      ),
    );
  }
}
