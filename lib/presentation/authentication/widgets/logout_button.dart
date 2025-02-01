import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_movie/presentation/authentication/blocs/auth/auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthLogoutButtonPressed()),
          child: const Text('Logout'),
        ),
      );
}
