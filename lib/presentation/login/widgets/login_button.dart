import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/login/blocs/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => ElevatedButton(
        onPressed: () => state.isSubmiting() || !state.isValid
            ? null
            : context.read<LoginBloc>().add(LoginButtonPressed()),
        child: Text(state.isSubmiting() ? 'Submitting' : 'Login'),
      ),
    );
  }
}
