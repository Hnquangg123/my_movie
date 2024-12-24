// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:my_movie/domain/movie/entities/movie.dart';
import 'package:my_movie/domain/movie/repositories/i_movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

@Injectable()
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IMovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
    on<FetchPopularMovies>(_onFetchPopularMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
      FetchNowPlayingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await movieRepository.getNowPlayingMovies();
    result.fold(
      (failure) => emit(MovieError(message: failure.message)),
      (movies) => emit(MovieLoaded(movies: movies)),
    );
  }

  Future<void> _onFetchPopularMovies(
      FetchPopularMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await movieRepository.getPopularMovies();
    result.fold(
      (failure) => emit(MovieError(message: failure.message)),
      (movies) => emit(MovieLoaded(movies: movies)),
    );
  }
}
