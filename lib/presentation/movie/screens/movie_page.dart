import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';
import 'package:my_movie/presentation/movie/widgets/now_playing_movies.dart';
import 'package:my_movie/presentation/movie/widgets/popular_movies.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final movieBloc = getIt<MovieBloc>();
        movieBloc.add(FetchPopularMovies());
        movieBloc.add(FetchNowPlayingMovies());
        return movieBloc;
      },
      child: const MovieContent(),
    );
  }
}

class MovieContent extends StatelessWidget {
  const MovieContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(height: 10),
        PopularMovies(),
        NowPlayingMovies(),
      ],
    );
  }
}
