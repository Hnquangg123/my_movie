part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends MovieEvent {}

class FetchNowPlayingMovies extends MovieEvent {}

class FetchTrendingMoviesAndTV extends MovieEvent {}

class FetchTVSeriesAirToday extends MovieEvent {}
