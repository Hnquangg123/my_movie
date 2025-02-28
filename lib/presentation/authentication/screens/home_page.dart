import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/presentation/authentication/blocs/auth/auth_bloc.dart';
import 'package:my_movie/presentation/authentication/blocs/navigation/nav_bloc.dart';
import 'package:my_movie/presentation/login/screens/login_page.dart';
import 'package:my_movie/presentation/movie/screens/movie_page.dart';
import 'package:my_movie/presentation/profile/screens/profile.dart';
import 'package:my_movie/presentation/recommendation/screens/recommendation.dart';
import 'package:my_movie/presentation/search/screens/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              context.read<NavBloc>().add(NavigateSearchPage());
              break;
            case 1:
              context.read<NavBloc>().add(NavigateHomePage());
              break;
            case 2:
              context.read<NavBloc>().add(NavigateProfilePage());
              break;
            case 3:
              context.read<NavBloc>().add(NavigateRecommendationPage());
              break;
          }
        },
        items: <Widget>[
          Icon(Icons.search),
          Icon(Icons.movie),
          Icon(Icons.person),
          Icon(Icons.recommend),
        ],
        height: MediaQuery.of(context).size.height * 0.07,
        index: 1,
        color: AppColors.scaffoldBackgroundColor,
        backgroundColor: AppColors.onSurfaceColor,
        buttonBackgroundColor: AppColors.surfaceColor,
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
          child: BlocBuilder<NavBloc, NavState>(
            builder: (context, state) {
              if (state is Search) {
                return SearchPage();
              }
              if (state is HomePage) {
                return MoviePage();
              }
              if (state is Profile) {
                return ProfilePage();
              }
              if (state is Recommendation) {
                return RecommendationPage();
              }
              return MoviePage();
            },
          ),
        ),
      ),
    );
  }
}
