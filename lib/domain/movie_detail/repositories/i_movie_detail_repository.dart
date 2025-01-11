import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie_detail/entities/detail.dart';

abstract class IMovieDetailRepository {
  Future<Either<Failure, Detail>> getMovieDetail(int id);
}
