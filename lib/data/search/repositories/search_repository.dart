import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/search/services/open_ai_service.dart';
import 'package:my_movie/data/search/services/tmdb_service.dart';


import 'package:my_movie/domain/movie/entities/movie.dart';
import 'package:my_movie/domain/search/repositories/i_search_repository.dart';

@Injectable(as: ISearchRepository)
class SearchRepository implements ISearchRepository {
  final TMDBService tmdbService;
  final OpenAIService openAIService;

  SearchRepository({
    required this.tmdbService,
    required this.openAIService,
  });

  @override
  Future<Either<Failure, List<dynamic>>> searchMovies(String query) async {
    try {
      final searchMovies = await tmdbService.searchMovies(query);
      return Right(searchMovies);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<double>>> generateEmbedding(String query) async {
    try {
      print('Go in embedding....');
      final embedding = await openAIService.generateEmbedding(query);
      return Right(embedding);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List>> filterMoviesByEmbedding(
      List<dynamic> movies, List<double> queryEmbedding) async {
    try {
      final enrichedMovies = await Future.wait(movies.map(
        (movie) async {
          final movieEmbedding = await openAIService
              .generateEmbedding(movie.title ?? movie.overview);

          final similarity = cosineSimilarity(queryEmbedding, movieEmbedding);

          if (movie is Movie) {
            final enrichedMovie = {
              'id': movie.id,
              'title': movie.title,
              'overview': movie.overview,
              'poster_path': movie.posterPath,
              'release_date': movie.releaseDate,
              'media_type': 'movie',
              'similarity': similarity,
            };

            return enrichedMovie;
          } else {
            final enrichedTV = {
              'id': movie.id,
              'title': movie.title,
              'overview': movie.overview,
              'poster_path': movie.posterPath,
              'release_date': movie.firstAirDate,
              'media_type': 'tv',
              'similarity': similarity,
            };

            return enrichedTV;
          }
        },
      ));

      print(enrichedMovies);

      enrichedMovies.sort((a, b) =>
          (b['similarity'] as double).compareTo(a['similarity'] as double));

      print('Sort: $enrichedMovies');

      return Right(enrichedMovies.take(10).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  double cosineSimilarity(List<double> vectorA, List<double> vectorB) {
    final dotProduct = vectorA
        .asMap()
        .entries
        .map((e) => e.value * vectorB[e.key])
        .reduce((a, b) => a + b);
    final magnitudeA = sqrt(vectorA.map((v) => v * v).reduce((a, b) => a + b));
    final magnitudeB = sqrt(vectorB.map((v) => v * v).reduce((a, b) => a + b));
    return dotProduct / (magnitudeA * magnitudeB);
  }


}
