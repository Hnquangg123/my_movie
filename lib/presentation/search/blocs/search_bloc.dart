import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/search/repositories/i_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

@Injectable()
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository _searchRepository;

  SearchBloc(this._searchRepository) : super(SearchInitial()) {
    on<SearchMoviesEmbedding>(_searchMoviesEmbedding);
    on<SearchMovies>(_searchMovies);
  }

  Future<void> _searchMovies(
      SearchMovies event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final searchMovies = await _searchRepository.searchMovies(event.query);

      await searchMovies.fold(
        (failure) async {
          if (!emit.isDone) emit(SearchError(message: 'Failed to load search'));
        },
        (movies) async {
          final currentSearchMovies =
              state is SearchLoaded ? (state as SearchLoaded).movies : {};

          emit(SearchLoaded(
            movies: {
              ...currentSearchMovies,
              'movies': movies,
            },
          ));
          // final data = (state as SearchLoaded).movies['movies'];
          // data?.forEach((movie) => print('Data: ${movie.mediaType}'),);
        },
      );
    } catch (e) {
      if (!emit.isDone) emit(SearchError(message: 'Failed to load search'));
    }
  }

  Future<void> _searchMoviesEmbedding(
      SearchMoviesEmbedding event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final searchMovies = await _searchRepository.searchMovies(event.query);

      await searchMovies.fold(
        (failure) async {
          if (!emit.isDone) emit(SearchError(message: 'Failed to load search'));
        },
        (movies) async {
          print('Search Movies: $movies');

          final queryEmbedding =
              await _searchRepository.generateEmbedding(event.query);

          await queryEmbedding.fold(
            (failure) async {
              if (!emit.isDone) {
                emit(SearchError(message: 'Failed to calculate embedding'));
              }
            },
            (embedding) async {
              // print(movies);
              // print(embedding);
              final enrichedMovies = await _searchRepository
                  .filterMoviesByEmbedding(movies, embedding);

              await enrichedMovies.fold((failure) async {
                if (!emit.isDone) {
                  emit(SearchError(message: 'Failed to filter movies'));
                }
              }, (enrichedMovies) async {
                // print('Vector Movies: $movies');

                final currentMovies =
                    state is SearchLoaded ? (state as SearchLoaded).movies : {};

                emit(SearchLoaded(movies: {
                  ...currentMovies,
                  'enriched_movies': enrichedMovies
                }));
              });
            },
          );
        },
      );
    } catch (e) {
      if (!emit.isDone) emit(SearchError(message: 'Failed to load search'));
    }
  }
}
