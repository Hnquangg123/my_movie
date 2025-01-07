import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/authentication/blocs/auth_bloc.dart';
import 'package:my_movie/presentation/login/screens/login_page.dart';
import 'package:my_movie/presentation/movie/screens/movie_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Movie'),
        actions: [
          _LogoutButton(),
        ],
      ),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserUnauthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
          },
          child: MoviePage(),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () =>
            context.read<AuthBloc>().add(AuthLogoutButtonPressed()),
        child: const Text('Logout'),
      );
}
