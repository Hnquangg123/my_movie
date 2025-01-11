import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/movie/services/fetch_movie_service.dart';
import 'package:my_movie/domain/movie/entities/movie.dart';
import 'package:my_movie/domain/movie/repositories/i_movie_repository.dart';

@Injectable(as: IMovieRepository)
class MovieRepository implements IMovieRepository {
  final FetchMovieService fetchMovieService;

  MovieRepository({required this.fetchMovieService});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final nowPlayingMovies = await fetchMovieService.fetchNowPlayingrMovies();
      return Right(nowPlayingMovies);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final popularMovies = await fetchMovieService.fetchPopularMovies();
      return Right(popularMovies);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<dynamic>>> getTrendingMoviesAndTV() async {
    try {
      final trendingMovies = await fetchMovieService.fetchTrendingMoviesAndTV();
      return Right(trendingMovies);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getTVSeriesAirToday() async {
    try {
      final tvSeriesAirToday = await fetchMovieService.fetchTVSeriesAirToday();
      return Right(tvSeriesAirToday);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
