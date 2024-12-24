import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/authentication/blocs/auth_bloc.dart'
    as auth_bloc;
import 'package:my_movie/presentation/authentication/screens/home_page.dart';
import 'package:my_movie/presentation/login/screens/login_page.dart';
import 'package:my_movie/presentation/authentication/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jwtjcjhnydruksviforg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3dGpjamhueWRydWtzdmlmb3JnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkzMDcwNDgsImV4cCI6MjA0NDg4MzA0OH0._rjnD_NE75qodjdMEp-GkpHcgf185mL9sixLmwfk4IA',
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  );

  configureDependencies();

  runApp(BlocProvider(
    create: (_) =>
        getIt<auth_bloc.AuthBloc>()..add(auth_bloc.AuthInitialCheckRequested()),
    child: const MyMovieApp(),
  ));
}

final supabase = Supabase.instance.client;

class MyMovieApp extends StatelessWidget {
  const MyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movie',
      home: BlocConsumer<auth_bloc.AuthBloc, auth_bloc.AuthState>(
        listener: (context, state) {
          if (state is auth_bloc.AuthUserUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
          if (state is auth_bloc.AuthUserAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        builder: (context, state) => const SplashScreen(),
      ),
    );
  }
}
