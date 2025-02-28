import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie/entities/movie.dart';

abstract class IMovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<dynamic>>> getNowPlayingMovies();
  Future<Either<Failure, List<dynamic>>> getTrendingMoviesAndTV();
  Future<Either<Failure, List<dynamic>>> getTVSeriesAirToday();
}
