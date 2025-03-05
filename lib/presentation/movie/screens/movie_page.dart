import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';
import 'package:my_movie/presentation/movie/widgets/now_playing_movies.dart';
import 'package:my_movie/presentation/movie/widgets/trending_movies.dart';
import 'package:my_movie/presentation/movie/widgets/tv_series.dart';
import 'package:rive/rive.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final movieBloc = getIt<MovieBloc>();
        // movieBloc.add(FetchPopularMovies());
        movieBloc.add(FetchTrendingMoviesAndTV());
        movieBloc.add(FetchNowPlayingMovies());
        movieBloc.add(FetchTVSeriesAirToday());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return state is MovieLoading
              ? RiveAnimation.asset('assets/animation/loading.riv')
              : SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      // SizedBox(height: 10),
                      // PopularMovies(),
                      TrendingMovies(),
                      NowPlayingMovies(),
                      TvSeries(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
