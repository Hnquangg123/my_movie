import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie_detail/entities/movie_detail.dart';

abstract class IMovieDetailRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
}
